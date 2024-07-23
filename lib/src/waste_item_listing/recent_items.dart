import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/waste_item_listing/details_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RecentItems extends StatefulWidget {
  const RecentItems({super.key});

  @override
  State<RecentItems> createState() => _RecentItemsState();
}

class _RecentItemsState extends State<RecentItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Items",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: fetchRecentItems(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHigh
                          .withOpacity(0.7),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            elevation: 10,
                            useRootNavigator: true,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: DetailsModal(
                                index: index,
                                snapshot: snapshot,
                              ),
                            ),
                          );
                        },
                        splashColor: Colors.grey,
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context).colorScheme.primaryFixed,
                        ),
                        title: Text(
                          snapshot.data[index]['name'],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, String>>> fetchRecentItems() async {
    final dio = Dio();
    List<Map<String, String>> data = [];
    try {
      final response = await dio.get(
        "$serverURLExpress/recent-show/shadmanskystar@gmail.com",
      );

      if (response.statusCode == 200) {
        for (final item in response.data) {
          data.add({
            "name": item['name'].toString(),
            "description": item['description'].toString(),
            "Amount": item['Amount'].toString(),
          });
        }
        return data;
      } else {
        throw createQuickAlert(
          context: context.mounted ? context : context,
          title: "${response.statusMessage}",
          message: "${response.statusCode}",
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
}
