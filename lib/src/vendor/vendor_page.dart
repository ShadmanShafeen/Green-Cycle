// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:green_cycle/src/vendor/vendor_approve_tab.dart';
import 'package:green_cycle/src/vendor/vendor_communities_tab.dart';
import 'package:green_cycle/src/vendor/vendor_map_tab.dart';
import 'package:green_cycle/src/vendor/vendor_profile_tab.dart';

class VendorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 1500),
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'GreenCycle',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                letterSpacing: 3),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            splashBorderRadius: BorderRadius.circular(30),
            tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.diversity_1),
            ),
            Tab(
              icon: Icon(Icons.location_on),
            ),
            Tab(
              icon: Icon(Icons.person),
            )

          ]),
        ),
        body: TabBarView(
          children: [
            VendorApproveTab(),
            VendorCommunitiesTab(),
            VendorMapTab(),
            VendorProfileTab()
          ],
        ),
      ),
    );
  }
}
