import 'package:flutter/material.dart';

import 'services/notification_service.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_menu_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notifications_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.initialize();

  runApp(const LearnerApp());
}

class LearnerApp extends StatelessWidget {
  const LearnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Learner App',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),

      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginScreen(),

        '/signup': (context) => const SignupScreen(),

        '/home': (context) => const HomeScreen(),

        '/detail': (context) => const DetailScreen(),

        '/profile': (context) => const ProfileScreen(),

        '/settings-menu': (context) =>
        const SettingsMenuScreen(),

        '/settings': (context) =>
        const SettingsScreen(),

        '/notifications': (context) =>
        const NotificationsScreen(),
      },
    );
  }
}