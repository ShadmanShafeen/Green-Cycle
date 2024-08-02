// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:green_cycle/src/vendor/vendor_widgets/vendor_community_card.dart';

class VendorCommunitiesTab extends StatelessWidget {
  const VendorCommunitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Text('Your Communities' , style: TextStyle(color: Theme.of(context).colorScheme.secondary),textScaler: TextScaler.linear(1.5),),
          Divider(color: Theme.of(context).colorScheme.secondary,),
          VendorCommunityCard(communityName: 'Mirpur DOHS', imagePath: 'lib/assets/images/Community-01.jpeg'),
          VendorCommunityCard(communityName: 'Dhaka Cantonment', imagePath: 'lib/assets/images/Community-03.jpeg'),
          VendorCommunityCard(communityName: 'Banani', imagePath: 'lib/assets/images/Community-02.jpeg'),
          VendorCommunityCard(communityName: 'Dhanmondi', imagePath: 'lib/assets/images/Community-04.jpeg'),
          ],
      ),
    );
  }
}
