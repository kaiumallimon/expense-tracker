import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light theme
ThemeData getTheme() => ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF336CFF),
          onPrimary: Colors.white,
          secondary: Color(0xFF183856),
          onSecondary: Colors.white,
          tertiary: Color(0xFFEF476F),
          onTertiary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black),
    );

// dark theme
ThemeData getDarkTheme() => ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF336CFF),
          onPrimary: Colors.white,
          secondary: Color(0xFF183856),
          onSecondary: Colors.white,
          tertiary: Color(0xFFEF476F),
          onTertiary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Color(0xFF121212),
          onSurface: Colors.white),
    );
