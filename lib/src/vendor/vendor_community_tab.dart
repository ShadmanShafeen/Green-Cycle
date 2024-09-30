// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/community/my_community_view/member-circle.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/vendor/vendor_widgets/member_add_modal.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';

class VendorCommunityTab extends StatefulWidget {
  VendorCommunityTab({super.key});
  late List ranked_members = [];
  late List members = [];
  @override
  State<VendorCommunityTab> createState() => _VendorCommunityTabState();
}

class _VendorCommunityTabState extends State<VendorCommunityTab> {
  bool isUser(String name) {
    if (name == 'You') {
      return true;
    }
    return false;
  }

  late var community;
  final dio = Dio();
  final vendor_email = Auth().currentUser?.email;

  Future<void> getCommunity() async {
    try {
      await dio.patch("$serverURLExpress/community/rank-members/$vendor_email");
      community = await dio
          .get("$serverURLExpress/vendor/fetch-community/$vendor_email");
     
      widget.ranked_members = community.data["rank"];
      widget.members = community.data['members'];
      
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/img/my_com_bg.jpg',
            ),
            fit: BoxFit.cover,
            opacity: .5,
          ),
        ),
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 350, child: topCard(context)),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: FutureBuilder(
                    future: getCommunity(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LinearProgressIndicator(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          color: Theme.of(context).colorScheme.surfaceBright,
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error Fetching Data"),
                        );
                      } else {
                        return ListView(
                          children: [
                            ...widget.members.asMap().entries.map((entry) {
                              int index =
                                  entry.key; // Get the index of the member
                              var member = entry.value; // Get the member itself

                              return Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.5),
                                child: ListTile(
                                  leading: Icon(Icons.person_2_rounded),
                                  title: Text(
                                    '${member.toString()}', // Show index (1-based)
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  trailing: CircleAvatar(
                                    child: Text(
                                        '${index + 1}'), // Show index inside CircleAvatar (optional)
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      }
                    })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            showDragHandle: true,
            context: context,
            builder: (ctx) => MemberAddModal(),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
    );
  }

  // Widget viewListItem(BuildContext context) {
  Widget topCard(BuildContext context) {
    return FutureBuilder(
        future: getCommunity(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
              color: Theme.of(context).colorScheme.surfaceBright,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error Fetching Data"),
            );
          } else {
            return Card(
              color: const Color(0xFF2C2C2C).withOpacity(0.7),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'lib/assets/img/leaderboard_bg3.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'My Community Members',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          // IconButton(
                          //   icon: const Icon(
                          //     Icons.logout,
                          //     color: Colors.white,
                          //   ),
                          //   onPressed: () {},
                          // ),
                        ],
                      ),
                      MemberCircle(
                        isVisible:
                            widget.ranked_members.length == 0 ? false : true,
                        imageUrl: 'lib/assets/img/avatar1.png',
                        name: widget.ranked_members.length > 0
                            ? widget.ranked_members[0]['name']
                            : "",
                        points: widget.ranked_members.length > 0
                            ? widget.ranked_members[0]['coins'].toString()
                            : "",
                        rank: 1,
                        isTopMember: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MemberCircle(
                            isVisible: widget.ranked_members.length <= 1
                                ? false
                                : true,
                            imageUrl: 'lib/assets/img/avatar2.png',
                            name: widget.ranked_members.length > 1
                                ? widget.ranked_members[1]['name']
                                : "",
                            points: widget.ranked_members.length > 1
                                ? widget.ranked_members[1]['coins'].toString()
                                : "",
                            rank: 2,
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          MemberCircle(
                            isVisible: widget.ranked_members.length <= 2
                                ? false
                                : true,
                            imageUrl: 'lib/assets/img/avatar3.png',
                            name: widget.ranked_members.length > 2
                                ? widget.ranked_members[2]['name']
                                : "",
                            points: widget.ranked_members.length > 2
                                ? widget.ranked_members[2]['coins'].toString()
                                : "",
                            rank: 3,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: FilledButton(
                              onPressed: () {
                                // context.go('/home/community-explore/com-goals');
                              },
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(240, 136, 68, 240),
                                ),
                                fixedSize: WidgetStatePropertyAll<Size>(
                                  Size.fromWidth(200),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Goals',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: FilledButton(
                              onPressed: () {
                                // context.go(
                                //     '/home/community-explore/community-calender');
                              },
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(240, 136, 68, 240),
                                ),
                                fixedSize: WidgetStatePropertyAll<Size>(
                                  Size.fromWidth(200),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Schedule',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
