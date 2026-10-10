import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;

  static const Color bg = Color(0xFF17152E);
  static const Color purple = Color(0xFF8B7CF6);
  static const Color cardBg = Color(0xFF24213F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preferences',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text(
                        'Push Notifications',
                        style: TextStyle(color: Colors.white),
                      ),
                      secondary: const Icon(Icons.notifications_outlined, color: purple),
                      activeColor: purple,
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    SwitchListTile(
                      title: const Text(
                        'Dark Mode',
                        style: TextStyle(color: Colors.white),
                      ),
                      secondary: const Icon(Icons.dark_mode_outlined, color: purple),
                      activeColor: purple,
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Support & About',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language, color: purple),
                      title: const Text(
                        'Language',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: const Text(
                        'English',
                        style: TextStyle(color: Colors.white60),
                      ),
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    ListTile(
                      leading: const Icon(Icons.info_outline, color: purple),
                      title: const Text(
                        'Privacy Policy',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    ListTile(
                      leading: const Icon(Icons.description_outlined, color: purple),
                      title: const Text(
                        'Terms & Conditions',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
