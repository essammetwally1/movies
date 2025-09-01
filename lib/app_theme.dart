import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFF6BD00);
  static const Color gray = Color(0xFF282A28);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFE82626);
  static const Color backgroundDark = Color(0xFF121312);

  static ThemeData lightTheme = ThemeData();
  static ThemeData dartTheme = ThemeData(
    scaffoldBackgroundColor: backgroundDark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(12),

      hintStyle: TextStyle(
        fontSize: 16,
        color: white,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: gray,
      ),

      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}
