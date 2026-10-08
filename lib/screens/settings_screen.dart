import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;
  String language = 'English';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      notifications =
          prefs.getBool('notifications_enabled') ?? true;

      darkMode =
          prefs.getBool('dark_mode_enabled') ?? false;

      language =
          prefs.getString('app_language') ?? 'English';
    });
  }

  Future<void> saveNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'notifications_enabled',
      value,
    );

    setState(() {
      notifications = value;
    });
  }

  Future<void> saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'dark_mode_enabled',
      value,
    );

    setState(() {
      darkMode = value;
    });
  }

  Future<void> saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'app_language',
      value,
    );

    setState(() {
      language = value;
    });
  }

  void chooseLanguage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: language,
                onChanged: (value) {
                  if (value != null) {
                    saveLanguage(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Arabic'),
                value: 'Arabic',
                groupValue: language,
                onChanged: (value) {
                  if (value != null) {
                    saveLanguage(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Application Settings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SwitchListTile(
            secondary: const Icon(
              Icons.notifications,
            ),
            title: const Text(
              'Notifications',
            ),
            subtitle: const Text(
              'Enable application notifications',
            ),
            value: notifications,
            onChanged: saveNotifications,
          ),

          SwitchListTile(
            secondary: const Icon(
              Icons.dark_mode,
            ),
            title: const Text(
              'Dark Mode',
            ),
            subtitle: const Text(
              'Use dark appearance',
            ),
            value: darkMode,
            onChanged: saveDarkMode,
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.language,
            ),
            title: const Text(
              'Language',
            ),
            subtitle: Text(language),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: chooseLanguage,
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.notifications_active,
            ),
            title: const Text(
              'Notification Center',
            ),
            subtitle: const Text(
              'View and test notifications',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/notifications',
              );
            },
          ),
        ],
      ),
    );
  }
}