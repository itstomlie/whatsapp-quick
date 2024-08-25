import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF263238),
    onPrimary: Color(0xFFFFFFFF),
    error: Color(0xFFD32F2F),
    background: Color(0xFFECEFF1),
    onBackground: Color.fromARGB(255, 223, 223, 223),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
    secondary: Color(0xFF00C853),
  ),
  fontFamily: GoogleFonts.firaSans().fontFamily,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF66BB6A), // A lighter, minty green
    onPrimary: Color(0xFF212121), // Dark grey for better contrast on primary
    error: Color(0xFFEF5350), // A softer red
    background: Color(0xFF263238), // Dark teal for background
    onBackground: Color(0xFF80CBC4), // Light teal for text on background
    surface: Color(0xFF37474F), // Dark grey-blue for surfaces
    onSurface: Color(0xFFECEFF1), // Off-white for text on surfaces
  ),
  // fontFamily: GoogleFonts.montserrat().fontFamily,
);
