import 'package:flutter/material.dart';
import 'package:green_cycle/src/community/explore_community/community_nearby_card.dart';
import 'package:green_cycle/src/models/community.dart';

class CommunitiesNearby extends StatelessWidget {
  const CommunitiesNearby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        child: ListView.builder(
          prototypeItem: const SizedBox(
            height: 200,
            width: double.infinity,
          ),
          itemCount: communities.length,
          itemBuilder: (BuildContext context, int index) {
            return CommunityNearbyCard(
              context: context,
              image: communities[index].image,
              title: communities[index].com_name,
              subtitle: communities[index].location,
            );
          },
        ),
      ),
    );
  }
}
