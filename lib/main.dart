import 'package:crunchyroll/page/login/login_page.dart';
import 'package:crunchyroll/page/login/register_page.dart';
import 'package:crunchyroll/page/services/firebase/firebase_api.dart';
import 'package:crunchyroll/page/services/firebase/firebase_options.dart';
import 'package:crunchyroll/page/view/notification/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crunchyroll/page/navbar_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  await FirebaseApi().initNotifications();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const NavbarHome() : const LoginPage(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => const NotificationPage(),
        '/home': (context) => const NavbarHome(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
