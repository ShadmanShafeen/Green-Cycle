import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/responsive_functions.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class RequestModal extends StatefulWidget {
  final Map<String, dynamic> community;

  const RequestModal({super.key, required this.community});

  @override
  State<RequestModal> createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal> {
  bool isRequesting = false;
  bool alreadyRequested = false;

  @override
  void initState() {
    super.initState();
    checkIfAlreadyRequested();
  }

  void checkIfAlreadyRequested() {
    final Auth auth = Auth();
    User? user = auth.currentUser;
    if (widget.community['join_requests'].contains("${user!.email}") ||
        widget.community['members'].contains("${user.email}")) {
      setState(() {
        alreadyRequested = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: alreadyRequested
                ? null
                : () {
                    sendRequestToCommunity(context);
                  },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).colorScheme.primaryFixed,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: alreadyRequested
                  ? Text(
                      "Already Requested or a member",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: dynamicFontSize(context, 12),
                      ),
                    )
                  : isRequesting
                      ? Text(
                          "Requesting...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: dynamicFontSize(context, 12),
                          ),
                        )
                      : Text(
                          "Request to join",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: dynamicFontSize(context, 12),
                          ),
                        ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text("Name"),
            subtitle: Text(widget.community['community_name']),
          ),
          ListTile(
            title: const Text("Vendor Email"),
            subtitle: Text(widget.community['vendor_email']),
          ),
        ],
      ),
    );
  }

  Future<void> sendRequestToCommunity(BuildContext context) async {
    final dio = Dio();
    try {
      setState(() {
        isRequesting = true;
      });
      final Auth auth = Auth();
      User? user = auth.currentUser;
      final response = await dio.post(
          "$serverURLExpress/request-community/${widget.community['community_name']}",
          data: {"email": "${user!.email}"});

      if (response.statusCode == 200) {
        setState(() {
          isRequesting = false;
          alreadyRequested = true;
        });
        await createQuickAlert(
          context: context.mounted ? context : context,
          title: "Request sent",
          message: "Your request has been sent to the community leader",
          type: "success",
        );
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
        title: "Failed to send request",
        message: "$e",
        type: "error",
      );
    }
  }
}
