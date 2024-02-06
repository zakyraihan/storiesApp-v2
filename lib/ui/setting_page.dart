import 'package:flutter/material.dart';
import 'package:story_app_api/controller/auth_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void logOut() {
    AuthController().logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setting page'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => logOut(),
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
          )
        ],
      ),
    );
  }
}
