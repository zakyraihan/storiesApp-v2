import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(255, 255, 255, 1);
const Color secondaryColor = Color(0xFF6B38FB);

// light theme
ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: primaryColor,
        onPrimary: Colors.black,
        secondary: secondaryColor,
      ),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

// dark theme
const Color darkPrimaryColor = Color(0xFF000000);
const Color darkSecondaryColor = Color(0xff64ffda);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: darkSecondaryColor,
        onPrimary: darkPrimaryColor,
        secondary: darkSecondaryColor,
      ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);
