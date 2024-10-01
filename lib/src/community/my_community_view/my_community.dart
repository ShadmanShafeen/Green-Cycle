import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/community/my_community_view/member-circle.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MyCommunity extends StatefulWidget {
  MyCommunity({super.key});
  late List ranked_members = [];
  late List members = [];
  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {
  bool isUser(String name) {
    if (name == 'You') {
      return true;
    }
    return false;
  }

  late var community;
  final Dio dio = Dio();
  final user_email = Auth().currentUser?.email;

  Future<void> getCommunity() async {
    try {
      await dio.patch("$serverURLExpress/community/rank-members/$user_email");
      community =
          await dio.get("$serverURLExpress/vendor/fetch-community/$user_email");

      widget.ranked_members = community.data["rank"];
      widget.members = community.data['members'];
    } catch (e) {
      createQuickAlert(
        context: context,
        title: "Error Fetching Community",
        message: "$e",
        type: "error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'My Community',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home/community-explore');
          },
        ),
      ),
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
        child: Column(
          children: [
            SizedBox(
              height: 380,
              child: topCard(context),
            ),
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
                                  leading: const Icon(Icons.person_2_rounded),
                                  title: Text(
                                    member.toString(), // Show index (1-based)
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  trailing: CircleAvatar(
                                    child: Text(
                                        '${index + 1}'), // Show index inside CircleAvatar (optional)
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }
                    })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createQuickAlertConfirm(
            context: context,
            title: "Are you sure?",
            message: "This will remove from the community",
            type: "confirm",
            onConfirmBtnTap: () async {
              try {
                final response = await dio.patch(
                  "$serverURLExpress/leave-community/$user_email",
                );

                if (response.statusCode == 200) {
                  createQuickAlert(
                    context: context,
                    title: "Success",
                    message: "You have left the ${community.data["name"]}",
                    type: "success",
                  );
                  context.go('/home/community-explore');
                } else {
                  createQuickAlert(
                    context: context,
                    title: "Error",
                    message: "Error leaving community",
                    type: "error",
                  );
                }
              } catch (e) {
                createQuickAlert(
                  context: context,
                  title: "Error",
                  message: "Error leaving community: $e",
                  type: "error",
                );
              }
            },
            onCancelBtnTap: () {
              context.pop();
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.logout_rounded),
      ),
    );
  }

  Widget topCard(BuildContext context) {
    return FutureBuilder(
      future: getCommunity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
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
                    const SizedBox(
                      height: 90,
                    ),
                    MemberCircle(
                      isVisible: widget.ranked_members.isEmpty ? false : true,
                      imageUrl: 'lib/assets/img/avatar1.png',
                      name: widget.ranked_members.isNotEmpty
                          ? widget.ranked_members[0]['name']
                          : "",
                      points: widget.ranked_members.isNotEmpty
                          ? widget.ranked_members[0]['coins'].toString()
                          : "",
                      rank: 1,
                      isTopMember: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MemberCircle(
                          isVisible:
                              widget.ranked_members.length <= 1 ? false : true,
                          imageUrl: 'lib/assets/img/avatar2.png',
                          name: widget.ranked_members.length > 1
                              ? widget.ranked_members[1]['name']
                              : "",
                          points: widget.ranked_members.length > 1
                              ? widget.ranked_members[1]['coins'].toString()
                              : "",
                          rank: 2,
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        MemberCircle(
                          isVisible:
                              widget.ranked_members.length <= 2 ? false : true,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 90,
                          child: FilledButton(
                            onPressed: () {
                              context.go('/home/community-explore/com-chat');
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
                                'Chat',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: FilledButton(
                            onPressed: () {
                              context.go(
                                '/home/community-explore/community-calender',
                              );
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
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: FilledButton(
                            onPressed: () async {
                              Map<String, dynamic> userInfo = {};
                              try {
                                final dio = Dio();
                                final email = community.data["vendor_email"];
                                final response = await dio
                                    .get('$serverURLExpress/user-info/$email');
                                if (response.statusCode == 200) {
                                  userInfo = response.data;
                                  if (context.mounted) {
                                    setState(() {});
                                  }
                                }

                                showModalBottomSheet(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  showDragHandle: true,
                                  context: context,
                                  elevation: 10,
                                  useRootNavigator: true,
                                  builder: (context) => SingleChildScrollView(
                                    controller:
                                        ModalScrollController.of(context),
                                    child:
                                        vendorDetailsModal(context, userInfo),
                                  ),
                                );
                              } catch (e) {
                                createQuickAlert(
                                  context: context.mounted ? context : context,
                                  title: "Error",
                                  message: "Error fetching vendor details: $e",
                                  type: "error",
                                );
                              }
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
                                'Vendor',
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
      },
    );
  }

  Container vendorDetailsModal(
      BuildContext context, Map<String, dynamic> vendorDetails) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Vendor Details",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildColumn(context, "Vendor Name", vendorDetails['name']),
                const SizedBox(height: 10),
                buildColumn(context, "Vendor Email", vendorDetails['email']),
                const SizedBox(height: 10),
                buildColumn(context, "Vendor Phone", vendorDetails['contact']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildColumn(BuildContext context, String title, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryFixed,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
