import "package:dio/dio.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:green_cycle/auth.dart";
import "package:green_cycle/src/notification/notification_service.dart";
import "package:green_cycle/src/utils/responsive_functions.dart";
import "package:green_cycle/src/utils/server.dart";
import "package:green_cycle/src/utils/snackbars_alerts.dart";

class AddNewItem extends StatefulWidget {
  final List<Map<String, String>> draftItems;
  final VoidCallback onNewItemAdded;
  const AddNewItem(
      {super.key, required this.draftItems, required this.onNewItemAdded});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NotificationService notificationService = NotificationService();
  final _itemNameController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  final _itemAmountController = TextEditingController();
  bool isAdding = false;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return AnimatedContainer(
      padding: EdgeInsets.only(
        top: 30,
        right: 25,
        left: 25,
        bottom: mediaQuery.viewInsets.bottom + 25,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add New Item",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getAddItemFormField(
                  context,
                  _itemNameController,
                  "Item Name",
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the item name';
                    }
                    return null;
                  },
                  TextInputType.text,
                  1,
                ),
                const SizedBox(height: 20),
                getAddItemFormField(
                  context,
                  _itemDescriptionController,
                  "Item Description",
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the item description';
                    }
                    return null;
                  },
                  TextInputType.multiline,
                  5,
                ),
                const SizedBox(height: 20),
                getAddItemFormField(
                  context,
                  _itemAmountController,
                  "Item Amount",
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the item amount';
                    }
                    return null;
                  },
                  TextInputType.number,
                  1,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final dio = Dio();
                      final Auth auth = Auth();
                      User? user = auth.currentUser;
                      try {
                        setState(() {
                          isAdding = true;
                        });
                        final response = await dio.post(
                          "$serverURLExpress/draft-insert/${user!.email}",
                          data: {
                            "name": _itemNameController.text,
                            "description": _itemDescriptionController.text,
                            "Amount": _itemAmountController.text,
                            'createdAt': getFormattedCurrentDate(),
                            'confirmedAt': 'Not Confirmed',
                          },
                        );

                        if (response.statusCode != 200) {
                          throw createQuickAlert(
                            context: context.mounted ? context : context,
                            title: "${response.statusCode}",
                            message: "${response.statusMessage}",
                            type: "error",
                          );
                        }

                        setState(() {
                          isAdding = false;
                        });
                        widget.onNewItemAdded();

                        Auth auth = Auth();
                        String? token = await auth.firebaseMessaging.getToken();

                        if (token != null) {
                          final name = _itemNameController.text;
                          final amount = _itemAmountController.text;
                          await notificationService.sendNotification(
                            "New item added to draft",
                            "Item name: $name\nAmount: $amount",
                            token,
                            context.mounted ? context : context,
                          );
                        }

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        throw createQuickAlert(
                          context: context.mounted ? context : context,
                          title: "Error",
                          message: e.toString(),
                          type: "error",
                        );
                      }
                    }
                  },
                  child: Text(
                    isAdding ? "Adding..." : "Add Item",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField getAddItemFormField(
      BuildContext context,
      TextEditingController fieldController,
      String labelText,
      String? Function(String?)? validator,
      TextInputType textType,
      int maxLines) {
    return TextFormField(
      keyboardType: textType,
      controller: fieldController,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      maxLines: maxLines,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
        focusColor: Theme.of(context).colorScheme.secondary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 10),
        label: Text(
          labelText,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      validator: validator,
    );
  }
}
