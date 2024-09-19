import 'package:flutter/material.dart';
import 'package:green_cycle/src/vendor/vendor_approve_tab.dart';
import 'package:green_cycle/src/vendor/vendor_communities_tab(old).dart';
import 'package:green_cycle/src/vendor/vendor_community_tab.dart';
import 'package:green_cycle/src/vendor/vendor_schedule_tab.dart';
import 'package:green_cycle/src/vendor/vendor_profile_tab.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({super.key});

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(seconds: 1),
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
            indicatorWeight: 1,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            splashBorderRadius: BorderRadius.circular(30),
            tabs: const [
              Tab(
                icon: Icon(Icons.recycling),
              ),
              Tab(
                icon: Icon(Icons.diversity_1),
              ),
              Tab(
                icon: Icon(Icons.event),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VendorApproveTab(),
            VendorCommunityTab(),
            VendorScheduleTab(),
            const VendorProfileTab(),
          ],
        ),
      ),
    );
  }
}
