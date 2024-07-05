import 'package:flutter/material.dart';

final class AppTheme {
  static const backgroudColor = Color.fromARGB(255, 230, 230, 230);
  static const primaryColor = Color.fromARGB(255, 153, 0, 0);
  static const secondaryColor = Color.fromARGB(255, 255, 200, 200);
  static const textColor = Color.fromARGB(255, 51, 51, 51);
  static const outlineColor = Color.fromARGB(255, 235, 235, 235);

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: outlineColor),
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
    useMaterial3: true,
    fontFamily: 'Raleway',
    scaffoldBackgroundColor: backgroudColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: secondaryColor,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: primaryColor,
        fontWeight: FontWeight.w700,
      ),
      floatingLabelStyle: const TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          )),
    ),
  );

  static final darkTheme = lightTheme;

  static const titleStyle = TextStyle(
    color: textColor,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    fontFamily: 'Raleway',
  );
  static const titleSmallStyle = TextStyle(
    color: textColor,
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontFamily: 'Raleway',
  );

  static const subTitleStyle = TextStyle(
    color: textColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Raleway',
  );
}
