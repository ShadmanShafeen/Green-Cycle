import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/notification/notification_service.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/waste_item_listing/add_new_item.dart';
import 'package:green_cycle/src/waste_item_listing/details_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DraftItems extends StatefulWidget {
  const DraftItems({super.key});

  @override
  State<DraftItems> createState() => _DraftItemsState();
}

class _DraftItemsState extends State<DraftItems>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isMultiSelectMode = false;
  List<int> selectedItems = [];
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final snackBar = createSnackBar(
          title: "Draft info",
          message: "Long press on the list item to delete it",
          contentType: "help");
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        child: Column(
          children: [
            //TITLE ROW
            _getTitleRow(context),
            //LIST VIEW
            Expanded(
              child: FutureBuilder(
                future: fetchDraftItems(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return _getListView(context, snapshot);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _getAddNewItemButton(context),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<Map<String, String>> draftItems = [];
  Future<List<Map<String, String>>> fetchDraftItems() async {
    try {
      draftItems.clear();
      final Auth auth = Auth();
      User? user = auth.currentUser;
      final response = await dio.get(
        "$serverURLExpress/draft-show/${user!.email}",
      );

      if (response.statusCode == 200) {
        for (var item in response.data) {
          draftItems.add({
            "name": item['name'].toString(),
            "description": item['description'].toString(),
            "Amount": item['Amount'].toString(),
            'createdAt': item['createdAt'].toString(),
            'confirmedAt': item['confirmedAt'].toString(),
          });
        }
        return draftItems;
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

  Future<void> deleteItem(int index, AsyncSnapshot snapshot) async {
    try {
      final Auth auth = Auth();
      User? user = auth.currentUser;
      final response = await dio.patch(
        "$serverURLExpress/draft-item-delete/${user!.email}",
        data: {
          "item": snapshot.data[index],
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          snapshot.data.removeAt(index);
        });
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
        title: "Failed to delete item",
        message: "$e",
        type: "error",
      );
    }
  }

  Future<void> deleteSelectedItems() async {
    try {
      final Auth auth = Auth();
      User? user = auth.currentUser;
      for (int index in selectedItems) {
        await dio.patch(
          "$serverURLExpress/draft-item-delete/${user!.email}",
          data: {
            "item": draftItems[index],
          },
        );
      }
      setState(() {
        for (int index in selectedItems) {
          draftItems.removeAt(index);
        }
        selectedItems.clear();
        isMultiSelectMode = false;
      });
    } catch (e) {
      throw createQuickAlert(
        context: context.mounted ? context : context,
        title: "Failed to delete items",
        message: "$e",
        type: "error",
      );
    }
  }

  ListView _getListView(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        final item = snapshot.data[index];
        final isSelected = selectedItems.contains(index);

        return Card(
          color: isSelected
              ? Theme.of(context).colorScheme.secondaryFixedDim
              : Theme.of(context)
                  .colorScheme
                  .surfaceContainerHigh
                  .withOpacity(0.7),
          shadowColor: Colors.transparent,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            onLongPress: () {
              setState(() {
                isMultiSelectMode = true;
                selectedItems.add(index);
              });
            },
            onTap: () {
              if (isMultiSelectMode) {
                setState(() {
                  if (isSelected) {
                    selectedItems.remove(index);
                    if (selectedItems.isEmpty) {
                      isMultiSelectMode = false;
                    }
                  } else {
                    selectedItems.add(index);
                  }
                });
              } else {
                showModalBottomSheet(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  showDragHandle: true,
                  context: context,
                  elevation: 10,
                  useRootNavigator: true,
                  builder: (context) => SingleChildScrollView(
                    controller: ModalScrollController.of(context),
                    child: DetailsModal(
                      index: index,
                      snapshot: snapshot,
                      isRecent: false,
                      element: item,
                    ),
                  ),
                );
              }
            },
            splashColor: Colors.grey,
            trailing: isMultiSelectMode
                ? Icon(
                    isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Theme.of(context).colorScheme.onSecondaryFixed,
                  )
                : Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
            title: Text(item['name']),
          ),
        );
      },
    );
  }

  Padding _getTitleRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Draft List",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isMultiSelectMode)
                IconButton(
                  onPressed: () async {
                    await deleteSelectedItems();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
              _getConfirmListButton(context),
            ],
          ),
        ],
      ),
    );
  }

  IconButton _getConfirmListButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (draftItems.isEmpty) {
          final snackBar = createSnackBar(
            title: "Draft List Empty",
            message: "Please add items to the draft list before confirming",
            contentType: "error",
          );
          ScaffoldMessenger.of(context.mounted ? context : context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          return;
        }

        final dio = Dio();
        try {
          final Auth auth = Auth();
          User? user = auth.currentUser;
          final response = await dio.post(
            "$serverURLExpress/draft-to-recent/${user!.email}",
          );

          if (response.statusCode == 200) {
            setState(() {
              draftItems.clear();
            });

            Auth auth = Auth();
            String? token = await auth.firebaseMessaging.getToken();
            if (token != null) {
              await NotificationService().sendNotification(
                "Draft items confirmed",
                "The items in your draft list have been confirmed and added to your recent list",
                token,
                context.mounted ? context : context,
              );
            }

            final snackBar = createSnackBar(
              title: "Draft Items Confirmed",
              message:
                  "The items in your draft list have been confirmed and added to your recent list.Thank you.",
              contentType: "success",
            );
            ScaffoldMessenger.of(context.mounted ? context : context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
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
            title: "Failed to save data",
            message: "$e",
            type: "error",
          );
        }
      },
      icon: Icon(
        Icons.save,
        color: Theme.of(context).colorScheme.primaryFixed,
      ),
    );
  }

  FloatingActionButton _getAddNewItemButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.onPrimaryFixed,
      ),
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Theme.of(context).colorScheme.surface,
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
                  message: "This item will not be added to the list",
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
                    message: "This item will not be added to the list",
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
                child: AddNewItem(
                    draftItems: draftItems,
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
}
