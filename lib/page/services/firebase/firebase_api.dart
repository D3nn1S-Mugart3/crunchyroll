import 'package:crunchyroll/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // Registration
  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Save additional user info in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'created_at': Timestamp.now(),
      });
      return userCredential.user;
    } catch (e) {
      print('Registration Error: $e');
      return null;
    }
  }

  // Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    // Sign out from Firebase
    await _auth.signOut();

    // Sign out from Google
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `Firebase.initializeApp()` before using them.
  print("Handling a background message: ${message.messageId}");
}
