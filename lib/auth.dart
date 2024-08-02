import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:green_cycle/main.dart';
import 'package:green_cycle/src/utils/server.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final _androidNotificationChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //init notifications
  Future<void> initNotifications() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      sendNotificationTokenToServer();
      initPushNotifications();
      initLocalNotifications();
      await firebaseMessaging.subscribeToTopic('all');
    } else {
      if (kDebugMode) {
        print('User declined permissions');
      }
    }
  }

  Future<void> sendNotificationTokenToServer() async {
    String? token = await firebaseMessaging.getToken();
    if (token != null) {
      deviceToken = token;
      final Dio dio = Dio();
      try {
        await dio.post(
          '$serverURLExpress/add-device-token',
          data: {
            'email': currentUser!.email,
            'token': token,
            'topic': 'all',
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer ${_firebaseAuth.currentUser!.uid}',
            },
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print('Error sending notification token to server: $e');
        }
      }
    }
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    final Dio dio = Dio();
    try {
      await dio.post(
        '$serverURLExpress/add-notification',
        data: {
          'email': currentUser!.email,
          'message': {
            "title": message.notification!.title,
            "text": message.notification!.body,
            "time": DateTime.now().toIso8601String(),
            "status": '0',
          },
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_firebaseAuth.currentUser!.uid}',
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error sending notification token to server: $e');
      }
    }
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
      navigatorKey.currentState?.pushNamed("/home/notification");
    });

    FirebaseMessaging.onMessage.listen((message) async {
      await handleMessage(message);
      final RemoteNotification? notification = message.notification;
      if (notification == null) return;

      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidNotificationChannel.id,
            _androidNotificationChannel.name,
            channelDescription: _androidNotificationChannel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@drawable/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      handleMessage(message);
    });

    firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    firebaseMessaging.onTokenRefresh.listen((token) {
      sendNotificationTokenToServer();
    });
  }

  Future<void> initLocalNotifications() async {
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) async {
              navigatorKey.currentState?.pushNamed("/home/notification");
            });
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (_) async {
      navigatorKey.currentState?.pushNamed("/home/notification");
    }, onDidReceiveNotificationResponse: (_) async {
      navigatorKey.currentState?.pushNamed("/home/notification");
    });

    final platform =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidNotificationChannel);
  }
}
