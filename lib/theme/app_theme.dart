import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    fontFamily: 'Poppins',

    colorScheme: ColorScheme.light(
      primary: const Color(0xFF1976d2),
      secondary: const Color(0xFF9c27b0),
    ),

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: 'Poppins',

    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF1976d2),
      secondary: const Color(0xFF9c27b0),
    ),

    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
    ),
  );
}
