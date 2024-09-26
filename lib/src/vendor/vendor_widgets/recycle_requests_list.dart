// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/notification/notification_service.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class RecycleRequestsList extends StatefulWidget {
  RecycleRequestsList({super.key});
  List recycleRequests = [];
  @override
  State<RecycleRequestsList> createState() => _RecycleRequestsListState();
}

class _RecycleRequestsListState extends State<RecycleRequestsList> {
  Future<void> getRecycleRequests() async {
    try {
      final dio = Dio();
      final vendor_email = Auth().currentUser?.email;
      final response = await dio
          .get("$serverURLExpress/vendor/fetch-recycle-requests/$vendor_email");
      widget.recycleRequests = response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<void> refreshRecycleRequests() async {
    try {
      final dio = Dio();
      final vendor_email = Auth().currentUser?.email;
      final response = await dio
          .get("$serverURLExpress/vendor/fetch-recycle-requests/$vendor_email");

      if (mounted) {
        setState(() {
          widget.recycleRequests = response.data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getRecycleRequests(); // Fetch requests when the widget is first built
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRecycleRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              color: Theme.of(context).colorScheme.surfaceBright,
              backgroundColor: Theme.of(context).colorScheme.surface,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error Loading Data"),
            );
          } else {
            return ListView(children: [
              ...widget.recycleRequests.map((request) =>
                  RecycleRequest(context, request, refreshRecycleRequests))
            ]);
          }
        });
  }
}

Widget RecycleRequest(context, request, refreshRecycleRequests) {
  String name = '';
  String contact = '';
  final email = request['email'];
  Future<void> getUserInfo() async {
    try {
      final dio = Dio();
      final response = await dio.get("$serverURLExpress/user-info/$email");
      name = response.data['name'];
      contact = response.data['contact'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> acceptRecycleRequest() async {
    try {
      final dio = Dio();
      final vendor_email = Auth().currentUser?.email;
      final request_id = request['_id'];
      print(request_id);
      await dio.patch(
          "$serverURLExpress/vendor/accept-recycle-request/$vendor_email/$request_id");
      final userInfo = await dio.get("$serverURLExpress/user-info/$email");

      if (userInfo.data['items_recycled'] >= 5 &&
          userInfo.data['current_level'] == 3) {
        await dio.patch("$serverURLExpress/level-up/$email");
        final token = userInfo.data['device_id'];
        await NotificationService().sendNotification(
            "You Leveled Up!",
            "Visit your levels page to view rewards",
            token,
            context.mounted ? context : context);
      }
      createQuickAlert(
          context: context,
          title: "Items Recycled",
          message: "Recycle Request Accepted",
          type: "success");
      await refreshRecycleRequests();
    } catch (e) {
      print(e);
    }
  }

  Future<void> rejectRecycleRequest() async {
    try {
      final dio = Dio();
      final vendor_email = Auth().currentUser?.email;
      final request_id = request['_id'];
      await dio.patch(
          "$serverURLExpress/vendor/reject-recycle-request/$vendor_email/$request_id");
      createQuickAlert(
          context: context,
          title: "Items Rejected",
          message: "Recycle Request Deleted",
          type: "error");
      await refreshRecycleRequests();
    } catch (e) {
      print(e);
    }
  }

  return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(
            color: Theme.of(context).colorScheme.surfaceBright,
            backgroundColor: Theme.of(context).colorScheme.surface,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error Fetching Data."),
          );
        } else {
          return Card(
            elevation: 10,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ExpansionTile(
              title: Text(name),
              subtitle: Text(
                '${request["email"]}',
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8)),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              expandedCrossAxisAlignment: CrossAxisAlignment.center,
              expandedAlignment: Alignment.topLeft,
              //Each Request's Items
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.3)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Contact No: $contact',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Items:',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      textScaler: TextScaler.linear(1.5),
                    ),
                  ),
                ),
                ...request['items'].map((item) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${item["amount"]} ${item["item_name"]}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).colorScheme.primary)),
                            icon: Icon(Icons.handshake,
                                color: Theme.of(context).colorScheme.onSurface),
                            onPressed: () async {
                              await acceptRecycleRequest();
                            },
                            label: Text(
                              'Confirm',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton.icon(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () async {
                              await rejectRecycleRequest();
                            },
                            label: Text(
                              "Reject",
                              style:
                                  TextStyle(color: Colors.redAccent.shade200),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      });
}
