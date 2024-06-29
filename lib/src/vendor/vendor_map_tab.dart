import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:green_cycle/src/Locate_Vendor/recents_modal.dart";
import "package:latlong2/latlong.dart";
import "package:modal_bottom_sheet/modal_bottom_sheet.dart";

class VendorMapTab extends StatelessWidget {
  VendorMapTab({super.key,});
  // final LocationData locationData;

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
            onPressed: () {},
          ),
        );
      },
    ).toList();
    return Placeholder();
    // return Scaffold(
    //   bottomNavigationBar: const NavBar(),
    //   appBar: AppBar(
    //     leading: IconButton(
    //       icon: const Icon(Icons.arrow_back),
    //       onPressed: () {
    //         context.pop();
    //       },
    //     ),
    //     title: const Text(
    //       "Locate Your Vendor",
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 25,
    //       ),
    //     ),
    //     centerTitle: true,
    //   ),
    //   body: FlutterMap(
    //     options: MapOptions(
    //       initialCenter: LatLng(
    //         locationData.latitude!.toDouble(),
    //         locationData.longitude!.toDouble(),
    //       ),
    //       initialZoom: 12,
    //     ),
    //     children: [
    //       TileLayer(
    //         urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    //         subdomains: const ['a', 'b', 'c'],
    //       ),
    //       MarkerLayer(
    //         markers: [
    //           Marker(
    //             width: 80.0,
    //             height: 80.0,
    //             point: LatLng(
    //               locationData.latitude!,
    //               locationData.longitude!,
    //             ),
    //             child: const Icon(
    //               Icons.location_on,
    //               color: Colors.red,
    //               size: 40.0,
    //             ),
    //           ),
    //           ...markers,
    //         ],
    //       ),
    //     ],
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       buildShowMaterialModalBottomSheet(context);
    //     },
    //     child: const Icon(Icons.search),
    //   ),
    // );
  }

  Future<dynamic> buildShowMaterialModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      elevation: 10,
      useRootNavigator: true,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: const RecentsModal(),
      ),
      showDragHandle: true,
    );
  }
}
