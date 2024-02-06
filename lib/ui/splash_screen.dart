import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app_api/controller/theme_controller.dart';
import 'package:story_app_api/data/preferences/preferences_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance()),
          ),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor:
                  provider.isDarkTheme ? Colors.grey : Colors.white,
              body: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Image.asset('assets/img/logo-removebg-preview.png'),
                  ),
                  const Text(
                    'Dicoding Indonesia',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
