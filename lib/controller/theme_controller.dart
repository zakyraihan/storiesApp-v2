import 'package:flutter/material.dart';
import 'package:story_app_api/common/styles.dart';
import 'package:story_app_api/data/preferences/preferences_helper.dart';

class ThemeProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  ThemeProvider({required this.preferencesHelper}) {
    _getTheme();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarktheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
    notifyListeners();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
}
