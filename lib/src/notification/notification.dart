import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/responsive_functions.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class NotificationContainer extends StatefulWidget {
  const NotificationContainer({super.key});

  @override
  State<NotificationContainer> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationContainer> {
  final Auth _auth = Auth();
  bool showEnablePushNotification = true;

  @override
  void initState() {
    super.initState();
    //check if notification is enabled in firebase messaging
    FirebaseMessaging.instance.getNotificationSettings().then((settings) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        setState(() {
          showEnablePushNotification = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const NavBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (showEnablePushNotification) buildTurnOnNotification(context),
            Expanded(
              child: FutureBuilder(
                future: fetchNotifications(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return buildGroupedListView(snapshot, context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  GroupedListView<dynamic, String> buildGroupedListView(
      AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    return GroupedListView<dynamic, String>(
      elements: snapshot.data,
      groupBy: (item) =>
          DateFormat('dd-MM-yyyy').format(DateTime.parse(item['time'])),
      groupComparator: (value1, value2) {
        DateTime date1 = parseDate(value1);
        DateTime date2 = parseDate(value2);
        return date1.compareTo(date2);
      },
      groupSeparatorBuilder: (String value) =>
          buildGroupSeparator(context, value),
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
          child: buildListTile(element, context),
        );
      },
    );
  }

  Container buildGroupSeparator(BuildContext context, String value) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        getDateInNormalText(value),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primaryFixed,
        ),
      ),
    );
  }

  ListTile buildListTile(element, BuildContext context) {
    return ListTile(
      onTap: () async {
        if (element['status'] == '0') {
          await createQuickAlert(
            context: context,
            title: element['title'],
            message: element['text'],
            type: "info",
          );

          final dio = Dio();
          try {
            User? user = _auth.currentUser;
            final response = await dio.patch(
                "$serverURLExpress/update-notification-status/${user!.email}/${element['time']}");
            if (response.statusCode == 200) {
              setState(() {});
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
              title: "Failed to update status",
              message: "$e",
              type: "error",
            );
          }
        }
      },
      splashColor: Colors.grey,
      leading: CircleAvatar(
        backgroundColor: element['status'] == '1'
            ? Colors.grey
            : Theme.of(context).colorScheme.primaryFixed,
        child: Icon(
          Icons.notifications,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      trailing: Icon(
        Icons.arrow_right,
        color: Theme.of(context).colorScheme.primaryFixed,
      ),
      title: Text(
        element['title'],
      ),
      subtitle: Text(
        element['text'],
      ),
    );
  }

  Future<List<Map<String, String>>> fetchNotifications() async {
    final dio = Dio();
    List<Map<String, String>> data = [];
    try {
      User? user = _auth.currentUser;
      final response = await dio.get(
        "$serverURLExpress/notifications/${user!.email}",
      );

      if (response.statusCode == 200) {
        final tempData = response.data['messages'];
        for (final item in tempData) {
          data.add({
            "title": item['title'].toString(),
            "text": item['text'].toString(),
            "time": item['time'].toString(),
            "status": item['status'].toString()
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

  Container buildTurnOnNotification(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            key: const Key('turn_on_notification'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Turn on push notifications",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: dynamicFontSize(context, 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enable push notifications to get notified on recycling schedules, messages, "
                  "notices and important news from your community. "
                  "Also stay up-to date with the latest features of the app",
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                    fontSize: dynamicFontSize(context, 11),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Auth auth = Auth();
                          await auth.initNotifications();
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                        child: Text(
                          "Turn on",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: dynamicFontSize(context, 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showEnablePushNotification = false;
                        });
                      },
                      child: Text(
                        "Not now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: dynamicFontSize(context, 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Lottie.asset(
            'lib/assets/animations/icons8-notification.json',
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
