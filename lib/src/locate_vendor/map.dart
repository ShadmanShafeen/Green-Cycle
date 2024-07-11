import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter/material.dart";
// import "package:flutter_app/src/home_page.dart";
import "package:flutter_map/flutter_map.dart";
import "package:green_cycle/src/Locate_Vendor/recents_modal.dart";
import "package:green_cycle/src/locate_vendor/location_details_modal.dart";
import "package:green_cycle/src/widgets/app_bar.dart";
import "package:green_cycle/src/widgets/nav_bar.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import "package:modal_bottom_sheet/modal_bottom_sheet.dart";

class LocateMap extends StatefulWidget {
  final LocationData locationData;
  const LocateMap({super.key, required this.locationData});

  @override
  State<LocateMap> createState() => _LocateMapState();
}

const String baseUrl =
    "https://api.openrouteservice.org/v2/directions/driving-car";
const String apiKey =
    "5b3ce3597851110001cf62489920d7719cd04fe98cb6bd743e92061f";

getRouterUrl(String startPoint, String endPoint) {
  return Uri.parse("$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint");
}

class _LocateMapState extends State<LocateMap> {
  final List<LatLng> markerLocation = [
    const LatLng(8.681495, 49.41461),
    const LatLng(8.687872, 49.420318),
  ];

  List listOfPoints = [];
  List<LatLng> points = [];

  @override
  void initState() {
    super.initState();
    getCoordinates(markerLocation[0].toString(), markerLocation[1].toString());
    print("GHELLOAFAWF");
  }

  Future<void> getCoordinates(String start, String end) async {
    var dio = Dio();
    var response = await dio.get(
      getRouterUrl(start, end),
    );

    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
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

    print(points);
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
                DetailsModal1(),
              );
            },
          ),
        );
      },
    ).toList();

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: NavBar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: markerLocation[0],
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
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
                  onPressed: () {
                    buildShowMaterialModalBottomSheet(
                      context,
                      DetailsModal1(),
                    );
                  },
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
        ],
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
}
