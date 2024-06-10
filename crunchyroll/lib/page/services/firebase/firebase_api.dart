import 'package:crunchyroll/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages here
      showDialog(
        context: navigatorKey.currentState!.context,
        builder: (_) {
          return AlertDialog(
            title: Text(message.notification?.title ?? 'No Title'),
            content: Text(message.notification?.body ?? 'No Body'),
            actions: [
              TextButton(
                onPressed: () {
                  navigatorKey.currentState?.pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `Firebase.initializeApp()` before using them.
  print("Handling a background message: ${message.messageId}");
}