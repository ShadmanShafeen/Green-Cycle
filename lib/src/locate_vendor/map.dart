import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_map/flutter_map.dart";
import "package:green_cycle/src/Locate_Vendor/recents_modal.dart";
import "package:green_cycle/src/locate_vendor/request_modal.dart";
import "package:green_cycle/src/utils/snackbars_alerts.dart";
import "package:green_cycle/src/widgets/app_bar.dart";
import "package:green_cycle/src/widgets/nav_bar.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import "package:modal_bottom_sheet/modal_bottom_sheet.dart";

import "../utils/server.dart";

class LocateMap extends StatefulWidget {
  final LocationData locationData;
  const LocateMap({super.key, required this.locationData});

  @override
  State<LocateMap> createState() => _LocateMapState();
}

final baseUrl = dotenv.get('BASE_LOCATION_URL');
final apiKey = dotenv.get('OPEN_ROUTE_API_KEY');
getRouterUrl(String startPoint, String endPoint) {
  return Uri.parse("$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint");
}

class _LocateMapState extends State<LocateMap> {
  late final double latitude;
  late final double longitude;
  late final LatLng currentLocation;
  List<LatLng> markerLocation = [
    // const LatLng(23.837842798083773, 90.35783819850069),
  ];

  List listOfPoints = [];
  List<LatLng> points = [];

  @override
  void initState() {
    super.initState();
    latitude = widget.locationData.latitude!;
    longitude = widget.locationData.longitude!;
    currentLocation = LatLng(latitude, longitude);
    final String startLocation =
        '${currentLocation.longitude},${currentLocation.latitude}';
    final String endLocation =
        '${currentLocation.longitude},${currentLocation.latitude}';
    getCoordinates(startLocation, endLocation);
  }

  Future<void> getCoordinates(String start, String end) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        "$baseUrl?api_key=$apiKey&start=$start&end=$end",
      );

      setState(() {
        if (response.statusCode == 200) {
          final data = response.data;
          listOfPoints = data['features'][0]['geometry']['coordinates'];
          points = listOfPoints
              .map(
                (p) => LatLng(
                  p[1].toDouble(),
                  p[0].toDouble(),
                ),
              )
              .toList();
        }
      });
    } catch (e) {
      throw createQuickAlert(
        context: context.mounted ? context : context,
        title: "OpenService Error.",
        message: "$e",
        type: "error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = markerLocation.map(
      (latLng) {
        return Marker(
          width: 80.0,
          height: 80.0,
          point: latLng,
          child: IconButton(
            icon: const Icon(Icons.location_on),
            color: Colors.blue,
            iconSize: 40.0,
            onPressed: () {
              buildShowMaterialModalBottomSheet(
                context,
                RequestModal(community: data[markerLocation.indexOf(latLng)]),
              );
            },
          ),
        );
      },
    ).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      bottomNavigationBar: const NavBar(),
      body: FutureBuilder(
        future: fetchAllCommunities(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return FlutterMap(
              options: MapOptions(
                keepAlive: true,
                initialCenter: currentLocation,
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'dev.leaflet.flutter.map.example',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(
                        widget.locationData.latitude!,
                        widget.locationData.longitude!,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ),
                    ...markers,
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points,
                      strokeWidth: 4.0,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildShowMaterialModalBottomSheet(
            context,
            const RecentsModal(),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Future<dynamic> buildShowMaterialModalBottomSheet(
      BuildContext context, Widget child) {
    return showModalBottomSheet(
      context: context,
      elevation: 10,
      useRootNavigator: true,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: child,
      ),
      showDragHandle: true,
    );
  }

  List<Map<String, dynamic>> data = [];
  Future<List<Map<String, dynamic>>> fetchAllCommunities(
      BuildContext context) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        "$serverURLExpress/communities",
      );

      if (response.statusCode == 200) {
        data.clear();
        for (final item in response.data) {
          List<String> joinRequests = [];
          for (final join in item['join_requests']) {
            joinRequests.add(join.toString());
          }

          List<String> members = [];
          for (final member in item['members']) {
            members.add(member.toString());
          }

          final Map<String, dynamic> community = {
            "community_name": item['community_name'].toString(),
            "location": LatLng(
              double.parse(item['location'][0]['latitude']),
              double.parse(item['location'][0]['longitude']),
            ),
            "image": item['image'].toString(),
            "vendor_email": item['vendor_email'].toString(),
            "join_requests": joinRequests,
            "members": members,
          };

          markerLocation.add(
            LatLng(
              double.parse(item['location'][0]['latitude']),
              double.parse(item['location'][0]['longitude']),
            ),
          );

          data.add(community);
        }

        return data;
      } else {
        throw createQuickAlert(
          context: context.mounted ? context : context,
          title: "${response.statusCode}",
          message: "${response.statusMessage}",
          type: "error",
        );
      }
    } catch (e) {
      throw createQuickAlert(
        context: context.mounted ? context : context,
        title: "Failed to load data",
        message: "$e",
        type: "error",
      );
    }
  }
}
