import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFF6BD00);
  static const Color grey = Color(0xFF282A28);
  static const Color darkGrey = Color(0xFF212121);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF121312);
  static const Color red = Color(0xFFE82626);
  static const Color backgroundDark = Color(0xFF121312);
  static const Color green = Colors.green;

  static ThemeData lightTheme = ThemeData();
  static ThemeData dartTheme = ThemeData(
    scaffoldBackgroundColor: backgroundDark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,

    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: primary,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      enableFeedback: false,
      backgroundColor: grey,
      type: BottomNavigationBarType.fixed,
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      filled: true,
      fillColor: grey,
      hintStyle: TextStyle(
        fontSize: 16,
        color: white,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: white),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: black,
      ),

      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: primary,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
        ),
      ),
    ),
  );
}
