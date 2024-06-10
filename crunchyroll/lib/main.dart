import 'package:crunchyroll/page/services/firebase/firebase_api.dart';
import 'package:crunchyroll/page/services/firebase/firebase_options.dart';
import 'package:crunchyroll/page/view/notification/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crunchyroll/page/navbar_home.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavbarHome(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => const NotificationPage(),
      },
    );
  }
}