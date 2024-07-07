import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTheme {
  static const backgroudColor = Color.fromARGB(255, 240, 240, 240);
  static const primaryColor = Color.fromARGB(255, 110, 0, 0);
  static const secondaryColor = Color.fromARGB(255, 255, 255, 255);
  static const textColor = Color.fromARGB(255, 50, 50, 50);
  static const outlineColor = Color.fromARGB(255, 220, 220, 220);
  static const gradientColor = [Color.fromARGB(255, 180, 0, 0), Color.fromARGB(255, 110, 0, 0)];

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: outlineColor),
  );
  static final _errorInputBorder = _defaultInputBorder.copyWith(
    borderSide: const BorderSide(color: Colors.red),
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
      errorBorder: _errorInputBorder,
      focusedErrorBorder: _errorInputBorder,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: primaryColor,
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

  static final titleStyle = GoogleFonts.raleway(
    textStyle: const TextStyle(
      color: textColor,
      fontSize: 32,
      fontWeight: FontWeight.w900,
    ),
  );

  static final titleSmallStyle = GoogleFonts.raleway(
    textStyle: const TextStyle(
      color: textColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
  );

  static final subTitleStyle = GoogleFonts.raleway(
    textStyle: const TextStyle(
      color: textColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}
