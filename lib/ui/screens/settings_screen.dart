import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Retention days'),
            subtitle: Text('Keep saved statuses for 7 days (auto-cleanup)'),
          ),
          ListTile(
            title: Text('Privacy policy'),
            subtitle: Text('No internet, no analytics. All data stays on your device.'),
          ),
        ],
      ),
    );
  }
}
