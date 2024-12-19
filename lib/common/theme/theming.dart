import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme() => ThemeData(
      // font family
      fontFamily: GoogleFonts.poppins().fontFamily,
      // color scheme: all the colors used in the app
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
