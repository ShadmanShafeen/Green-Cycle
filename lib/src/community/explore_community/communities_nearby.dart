import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/src/community/explore_community/add_new_community.dart';
import 'package:green_cycle/src/community/explore_community/communityDetailsModal.dart';
import 'package:green_cycle/src/community/explore_community/community_nearby_card.dart';
import 'package:green_cycle/src/models/community.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommunitiesNearby extends StatefulWidget {
  const CommunitiesNearby({super.key});

  @override
  State<CommunitiesNearby> createState() => _CommunitiesNearbyState();
}

class _CommunitiesNearbyState extends State<CommunitiesNearby> {
  late final LocationData locationData;

  @override
  void initState() {
    super.initState();
    checkForLocationPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _getAddNewCommunityButton(context),
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
            return buildCommunitiesContainer(context, snapshot);
          }
        },
      ),
    );
  }

  Container buildCommunitiesContainer(
      BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
      child: ListView.builder(
        prototypeItem: const SizedBox(
          height: 200,
          width: double.infinity,
        ),
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          final List<Community> communities = snapshot.data;
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                showDragHandle: true,
                elevation: 10,
                useRootNavigator: true,
                context: context,
                builder: (context) => SingleChildScrollView(
                  controller: ModalScrollController.of(context),
                  child: CommunityDetailsModal(
                    community: communities[index],
                  ),
                ),
              );
            },
            child: CommunityNearbyCard(
              context: context,
              image: communities[index].image,
              title: communities[index].name,
              subtitle: "Tap to show more details about this community",
            ),
          );
        },
      ),
    );
  }

  List<Community> data = [];

  Future<List<Community>> fetchAllCommunities(BuildContext context) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        "$serverURLExpress/communities",
      );

      if (response.statusCode == 200) {
        data.clear();
        for (final item in response.data) {
          final List<String> members = [];
          for (final member in item['members']) {
            members.add(member.toString());
          }

          final List<String> requests = [];
          for (final request in item['requests']) {
            requests.add(request.toString());
          }

          final List<Rank> rank = [];
          for (final r in item['rank']) {
            rank.add(Rank(
              r['member_email'].toString(),
              r['position'].toString(),
              r['coins'].toString(),
            ));
          }

          final List<Schedule> schedule = [];
          for (final s in item['schedule']) {
            schedule.add(Schedule(
              s['date'].toString(),
              s['event'].toString(),
            ));
          }

          final Community community = Community(
            item['image'].toString(),
            item['name'].toString(),
            CommunityLocation(
              double.tryParse(item['location'][0]['latitude'])!,
              double.tryParse(item['location'][0]['longitude'])!,
            ),
            item['leader_email'].toString(),
            members,
            requests,
            rank,
            schedule,
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

  FloatingActionButton _getAddNewCommunityButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.onSecondaryFixed,
      ),
      onPressed: () {
        showModalBottomSheet(
          showDragHandle: true,
          isScrollControlled: true,
          elevation: 10,
          useRootNavigator: true,
          context: context,
          builder: (context) => PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (didPop) return;
              final NavigatorState navigator = Navigator.of(context);
              bool shouldPop = false;
              await createQuickAlertConfirm(
                  context: context,
                  title: "Discard changes?",
                  message: "The community will not be created",
                  type: "confirm",
                  onConfirmBtnTap: () {
                    shouldPop = true;
                    navigator.pop();
                  },
                  onCancelBtnTap: () {
                    shouldPop = false;
                    navigator.pop();
                  });
              if (shouldPop) {
                navigator.pop();
              }
            },
            child: GestureDetector(
              onVerticalDragUpdate: (details) async {
                final NavigatorState navigator = Navigator.of(context);
                bool shouldPop = false;
                await createQuickAlertConfirm(
                    context: context,
                    title: "Discard changes?",
                    message: "The community will not be created",
                    type: "confirm",
                    onConfirmBtnTap: () {
                      shouldPop = true;
                      navigator.pop();
                    },
                    onCancelBtnTap: () {
                      shouldPop = false;
                      navigator.pop();
                    });
                if (shouldPop) {
                  navigator.pop();
                }
              },
              child: SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: AddNewCommunity(
                    communities: data,
                    communityLocation: locationData,
                    onNewItemAdded: () {
                      setState(() {});
                    }),
              ),
            ),
          ),
        );
      },
    );
  }

  void checkForLocationPermission(BuildContext context) async {
    final Location location = Location();
    bool serviceStatus = await location.serviceEnabled();
    if (!serviceStatus && context.mounted) {
      serviceStatus = await location.requestService();
    }

    locationData = await location.getLocation();
  }
}
