import 'package:flutter/material.dart';

final class AppTheme {
  static const orangeColor = Color.fromARGB(255, 255, 174, 69);
  static const lightOrangeColor = Color.fromARGB(255, 255, 239, 233);
  static const blueColor = Color.fromARGB(255, 1, 189, 214);
  static const lightGreyColor = Color.fromARGB(255, 235, 235, 235);

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: lightGreyColor),
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: lightOrangeColor),
    useMaterial3: true,
    fontFamily: 'Raleway',
    scaffoldBackgroundColor: orangeColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightOrangeColor,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: orangeColor,
        fontWeight: FontWeight.w700,
      ),
      floatingLabelStyle: const TextStyle(
        color: blueColor,
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
          backgroundColor: blueColor,
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
    color: blueColor,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    fontFamily: 'Raleway',
  );
  static const titleSmallStyle = TextStyle(
    color: blueColor,
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontFamily: 'Raleway',
  );

  static const subTitleStyle = TextStyle(
    color: blueColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Raleway',
  );
}
