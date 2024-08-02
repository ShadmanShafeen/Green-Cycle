import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class NotificationService {
  final Dio _dio = Dio();

  Future<void> sendNotification(
      String title, String body, String token, BuildContext context) async {
    const String fcmUrl = '$serverURLExpress/send-notification';
    final message = {
      'message': {
        'notification': {
          'title': title,
          'body': body,
        },
        'token': token,
        "android": {
          "notification": {
            "sound": "default",
          },
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        }
      },
    };

    try {
      await _dio.post(
        fcmUrl,
        data: message,
      );
    } catch (e) {
      await createQuickAlert(
        context: context.mounted ? context : context,
        title: "Error",
        message: e.toString(),
        type: "error",
      );
    }
  }
}
