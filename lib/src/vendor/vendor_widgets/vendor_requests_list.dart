// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:green_cycle/src/models/vendor_request.dart';

class VendorRequestsList extends StatefulWidget {
  const VendorRequestsList({super.key});

  @override
  State<VendorRequestsList> createState() => _VendorRequestsListState();
}

class _VendorRequestsListState extends State<VendorRequestsList> {
  List<VendorRequest> vendorRequests = [
    VendorRequest(
        userID: '123',
        userName: 'Shadman Shafeen',
        items: {'blankets': 3, 'glass bottles': 10, 'books': 12},
        contactNo: '01677188999',
        imagePath: ''),
    VendorRequest(
        userID: '113',
        userName: 'Abrar Mahir Esam',
        items: {'books': 5, 'plastic cups': 9, 'glass jars': 12},
        contactNo: '01715145333',
        imagePath: ''),
    VendorRequest(
        userID: '257',
        userName: 'Waliza Chowdhury',
        items: {'cardboard box': 4, 'plastic bottles': 10, 'aluminium cans': 12},
        contactNo: '01711839019',
        imagePath: ''),
    VendorRequest(
        userID: '462',
        userName: 'Nishat Tabassum',
        items: {'newspapers': 20, 'plastic items': 3, 'jute basket': 7},
        contactNo: '01711839019',
        imagePath: ''),
  ];

  @override
  Widget build(BuildContext context) {
    List<VendorRequest> pendingVendorRequests = vendorRequests.where((request) => !request.isAccepted).toList();
    return ListView(children: [
      ...pendingVendorRequests.map((VendorRequest request) => Card(
            elevation: 10,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ExpansionTile(
              title: Text(request.userName),
              subtitle: Text(
                'User ID : ${request.userID}',
                style: TextStyle(
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
                        'Contact No: ${request.contactNo}',
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
                ...request.items.entries.map((item) => SizedBox(
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
                                '${item.value} ${item.key}',
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
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                        icon: Icon(Icons.handshake,
                            color: Theme.of(context).colorScheme.onSurface),
                        onPressed: () {
                          setState(() {
                            request.isAccepted = !request.isAccepted;
                          });
                        },
                        label: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        )),
                  ),
                )
              ],
            ),
          ))
    ]);
  }
}
