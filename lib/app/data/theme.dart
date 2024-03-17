import 'package:flutter/material.dart';

const Color _primaryColor = Color(0xFF25D366); // Green (customizable)
const Color _lightColorSchemePrimary = Colors.white;
const Color _darkColorSchemePrimary = Colors.black;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.lightBlue,
      tertiary:
          Color.fromARGB(158, 228, 228, 228), // Adjust for your preference
      background: _lightColorSchemePrimary,
      surface: _lightColorSchemePrimary,
      onPrimary: Colors.black),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black),
    toolbarTextStyle:
        const TextTheme(titleLarge: TextStyle(color: Colors.white)).bodyMedium,
    titleTextStyle: const TextTheme(titleLarge: TextStyle(color: Colors.white))
        .titleLarge, // Consider contrast
  ),
  canvasColor: _lightColorSchemePrimary,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black), // Adjust for readability
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey[200], // Adjust for background clarity,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColor,
  colorScheme: const ColorScheme.dark(
    primary: Colors.pink,
    secondary: Colors.purple,
    tertiary: Colors.grey,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme:
        IconThemeData(color: Colors.white), // Adjust for contrastider contrast
  ),
  canvasColor: _darkColorSchemePrimary,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white), // Adjust for readability
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: const Color.fromARGB(255, 34, 34, 34), // Adjust for background clarity
  ),
);
