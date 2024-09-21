// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';

class RecycleRequestsList extends StatefulWidget {
  const RecycleRequestsList({super.key});

  @override
  State<RecycleRequestsList> createState() => _RecycleRequestsListState();
}

class _RecycleRequestsListState extends State<RecycleRequestsList> {
  List recycleRequests = [];
  Future<void> getRecycleRequests() async {
    try {
      final dio = Dio();
      final vendor_email = Auth().currentUser?.email;
      final response = await dio
          .get("$serverURLExpress/vendor/fetch-recycle-requests/$vendor_email");
      recycleRequests = response.data;
      
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
            return Center();
          } else {
            return ListView(children: [
              ...recycleRequests.map((request) =>
                  RecycleRequest(context, request, getRecycleRequests))
            ]);
          }
        });
  }
}

Widget RecycleRequest(context, request, getRecycleRequests) {
  String name = '';
  String contact = '';
  Future<void> getUserInfo() async {
    try {
      final dio = Dio();
      final email = request['email'];
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
      await dio.patch(
          "$serverURLExpress/vendor/accept-recycle-request/$vendor_email/$request_id");
      await getRecycleRequests();
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
      await getRecycleRequests();
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
