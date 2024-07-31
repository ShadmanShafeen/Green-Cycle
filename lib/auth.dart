import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:green_cycle/main.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

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

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> initNotifications() async {
    final String? token = await _firebaseMessaging.getToken();
    initPushNotification();
  }

  void handleMessageTapOnMobile(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed("/home/notification");
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      handleMessageTapOnMobile(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessageTapOnMobile(message);
    });

    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   await Firebase.initializeApp();
    //   handleMessageTapOnMobile(message);
    // });
  }
}
