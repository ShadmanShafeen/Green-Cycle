import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/community/my_community_view/new_mem_req.dart';
import 'package:green_cycle/src/notification/notification_service.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class MemberAddModal extends StatefulWidget {
  MemberAddModal({super.key});
  late List joinRequests = [];
  @override
  State<MemberAddModal> createState() => _MemberAddModalState();
}

class _MemberAddModalState extends State<MemberAddModal> {
  final dio = Dio();
  final vendor_email = Auth().currentUser?.email;
  Future<void> getJoinRequests() async {
    try {
      final response =
          await dio.get("$serverURLExpress/vendor/join-requests/$vendor_email");
      widget.joinRequests = response.data[0]['join_requests'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> refreshJoinRequests() async {
    try {
      final response =
          await dio.get("$serverURLExpress/vendor/join-requests/$vendor_email");
      if (mounted) {
        setState(() {
          widget.joinRequests = response.data[0]['join_requests'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> acceptJoinRequest(email) async {
    try {
      await dio.patch(
          "$serverURLExpress/vendor/accept-join-request/$vendor_email/$email");

      final userData = await dio.get("$serverURLExpress/user-info/$email");
      if (userData.data['current_level'] == 1) {
        await dio.patch("$serverURLExpress/level-up/$email");
        final token = userData.data['device_id'];
        await NotificationService().sendNotification(
            "You Leveled Up!",
            "Visit your levels page to view rewards",
            token,
            context.mounted ? context : context);
      }
      createQuickAlert(
          context: context,
          title: "Request Accepted",
          message: "New member added to your community",
          type: "success");
      await refreshJoinRequests();
    } catch (e) {
      print(e);
    }
  }

  Future<void> rejectJoinRequest(email) async {
    try {
      await dio.patch(
          "$serverURLExpress/vendor/reject-join-request/$vendor_email/$email");
      await refreshJoinRequests();
      createQuickAlert(
          context: context,
          title: "Request Deleted",
          message: "Member join request denied",
          type: "error");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          image: DecorationImage(
              image: AssetImage(
                'lib/assets/img/member_modal_bg.jpg',
              ),
              fit: BoxFit.cover,
              invertColors: true,
              opacity: 0.5)),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                'Member Requests',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: getJoinRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Error Fetching Data :(',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return ListView(
                        children: [
                          ...widget.joinRequests.map((email) => Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryFixedDim
                                    .withOpacity(0.7),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ExpansionTile(
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  title: Text(
                                    email.toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 12),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await acceptJoinRequest(email);
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll<
                                                        Color>(Theme.of(
                                                            context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.75))),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await rejectJoinRequest(email);
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll<
                                                        Color>(Theme.of(
                                                            context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.75))),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Reject',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
