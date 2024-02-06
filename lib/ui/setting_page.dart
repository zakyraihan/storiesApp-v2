import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_api/controller/auth_controller.dart';
import 'package:story_app_api/controller/theme_controller.dart';
import 'package:story_app_api/widget/platform_widget.dart';

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
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings '),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            ListTile(
              onTap: () => logOut(),
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Switch.adaptive(
                value: provider.isDarkTheme,
                onChanged: (value) {
                  provider.enableDarkTheme(value);
                },
              ),
              title: const Text('Dark Mode'),
            )
          ],
        );
      },
    );
  }
}
