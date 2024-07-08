// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class VendorCommunityCard extends StatelessWidget {
  const VendorCommunityCard({super.key, required this.communityName, required this.imagePath});

  final String communityName;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.black12]),
              borderRadius: BorderRadius.circular(10)),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  communityName,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontStyle: FontStyle.italic),
                  textScaler: TextScaler.linear(1.5),
                ),
              )),
        ),
      )),
    );
  }
}
