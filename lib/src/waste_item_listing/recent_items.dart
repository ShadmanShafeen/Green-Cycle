import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/responsive_functions.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/waste_item_listing/details_modal.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RecentItems extends StatefulWidget {
  const RecentItems({super.key});

  @override
  State<RecentItems> createState() => _RecentItemsState();
}

class _RecentItemsState extends State<RecentItems>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                onPressed: () {
                  setState(() {});
                },
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
                return GroupedListView<dynamic, String>(
                  elements: snapshot.data,
                  groupBy: (item) => item['confirmedAt']!,
                  groupComparator: (value1, value2) {
                    DateTime date1 = parseDate(value1);
                    DateTime date2 = parseDate(value2);
                    return date1.compareTo(date2);
                  },
                  groupSeparatorBuilder: (String value) => Container(
                    color: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getDateInNormalText(value),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                  ),
                  useStickyGroupSeparators: true,
                  groupStickyHeaderBuilder: (dynamic value) => Container(
                    color: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getDateInNormalText(value['confirmedAt']),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                  ),
                  order: GroupedListOrder.DESC,
                  indexedItemBuilder: (context, element, index) {
                    return Card(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHigh
                          .withOpacity(0.7),
                      shadowColor: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            showDragHandle: true,
                            context: context,
                            elevation: 10,
                            useRootNavigator: true,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: DetailsModal(
                                index: index,
                                snapshot: snapshot,
                                isRecent: true,
                                element: element,
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
                          element['name'],
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
      final Auth auth = Auth();
      User? user = auth.currentUser;
      final response = await dio.get(
        "$serverURLExpress/recent-show/${user!.email}",
      );

      if (response.statusCode == 200) {
        for (final item in response.data) {
          data.add({
            "name": item['name'].toString(),
            "description": item['description'].toString(),
            "Amount": item['Amount'].toString(),
            'createdAt': item['createdAt'].toString(),
            'confirmedAt': item['confirmedAt'].toString(),
          });
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
}
