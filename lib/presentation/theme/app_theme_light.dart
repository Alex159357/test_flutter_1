import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeLight {
  static AppThemeLight get instance => AppThemeLight();

  final ThemeData theme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF158A8A),
        onPrimary: Colors.black,
        secondary: Colors.transparent,
        onSecondary: Colors.transparent,
        error: Color(0xFFFF505A),
        onError: Colors.transparent,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Color(0xFFEEEEEE),
        onSurface: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.prata(
            fontSize: 46, fontWeight: FontWeight.w400, color: Colors.black),
        bodySmall: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9D9D9D)),
        titleMedium: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
            color: const Color(0xFF313131)),
        titleSmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
            color: const Color(0xFF313131)),
        labelMedium: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
        labelLarge: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
      ),
      dividerTheme: const DividerThemeData(
          endIndent: 10, indent: 10,
          color: Colors.black38),
      cardTheme: CardTheme(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withOpacity(.7),
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          foregroundColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF158A8A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.13),
              ),
              minimumSize: const Size.fromHeight(50),
              disabledBackgroundColor: Colors.black38)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.13),
          ),
        ),
      ));
}
