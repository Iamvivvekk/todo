import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color whiteColor = const Color(0xFFFFFFFF);

  static Color lightBlackColor = const Color(0xFF2A2828);

  static Color blackColor = const Color(0xFF000000);

  static Color greenColor = const Color(0xFF6EC270);

  static Color blueColor = const Color(0xFF1C71B8);

  static Color redColor = const Color(0xE9F44336);

  static ThemeData lightTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBlackColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: whiteColor,
        textStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
