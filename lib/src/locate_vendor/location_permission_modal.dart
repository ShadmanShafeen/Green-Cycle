// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';

class LocationPermissionModal extends StatefulWidget {
  const LocationPermissionModal({super.key});

  @override
  LocationPermissionModalState createState() => LocationPermissionModalState();
}

class LocationPermissionModalState extends State<LocationPermissionModal> {
  Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  Future<bool> checkLocationPermission() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    locationData = await location.getLocation();
    return serviceEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'GreenCycle wants to know your location',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 184, 43, 219),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () async {
              final mapShow = await checkLocationPermission();
              if (mapShow & context.mounted) {
                context.pop();
                context.go(
                  "/home/locate-map",
                  extra: locationData,
                );
              }
            },
            child: Text(
              'Allow Location Access',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 184, 43, 219),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Deny Location Access',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 184, 43, 219),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
