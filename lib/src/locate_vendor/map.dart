import "package:flutter/material.dart";
// import "package:flutter_app/src/home_page.dart";
import "package:flutter_map/flutter_map.dart";
import "package:green_cycle/src/Locate_Vendor/recents_modal.dart";
import "package:green_cycle/src/locate_vendor/location_details_modal.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import "package:modal_bottom_sheet/modal_bottom_sheet.dart";

class LocateMap extends StatelessWidget {
  final LocationData locationData;

  LocateMap({super.key, required this.locationData});

  final List<LatLng> markerLocation = [
    const LatLng(23.8103, 90.4125),
    const LatLng(23.8150, 90.4250),
  ];

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
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            locationData.latitude!.toDouble(),
            locationData.longitude!.toDouble(),
          ),
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                  locationData.latitude!,
                  locationData.longitude!,
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
