import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1B5E20), // A deeper, richer green
    onPrimary: Color(0xFFFFFFFF), // White for better contrast on primary
    error: Color(0xFFD32F2F), // A more vibrant red
    background: Color(0xFFE8F5E9), // A softer green tint for the background
    onBackground: Color(0xFF388E3C), // Darker green for text on background
    surface: Color(0xFFFFFFFF), // Pure white for surfaces
    onSurface: Color(0xFF212121), // Dark grey for text on surfaces
  ),
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
);

ThemeData otherTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(
        255, 34, 39, 39), // Light cyan, matching the background's soft colors
    onPrimary: Color(0xFF212121), // Darker gray for contrast
    error: Color(0xFFD32F2F), // Red for error messages
    background: Color(
        0xFFFFF7FA), // Very light pink to blend with the background gradient
    onBackground: Color(0xFF424242), // Darker gray for text on background
    surface: Color(0xFFFAFAFA), // Very light gray for cards and surfaces
    onSurface: Color(0xFFFFF7FA), // Dark gray for text on surfaces
    secondary: Color(0xFFF8BBD0), // Light pink to match the gradient colors
    onSecondary:
        Color(0xFF212121), // Darker gray for text on secondary surfaces
  ),
  fontFamily:
      'Raleway', // A modern and clean sans-serif font to complement the soft theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF212121),
    ),
    displayMedium: TextStyle(
      fontSize: 16.0,
      color: Color(0xFF424242),
    ),
  ),
);

ThemeData oceanTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1565C0),
    onPrimary: Color(0xFFFFFFFF),
    error: Color(0xFFD32F2F),
    background: Color(0xFFECEFF1),
    onBackground: Color(0xFF1565C0),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
    secondary: Color(0xFF00BCD4),
  ),
);

ThemeData sunsetTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFFF5722),
    onPrimary: Color(0xFFFFFFFF),
    error: Color(0xFFD32F2F),
    background: Color(0xFFFFDAB9),
    onBackground: Color(0xFFFF5722),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
    secondary: Color(0xFF673AB7),
  ),
);

ThemeData monochromeTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF424242),
    onPrimary: Color(0xFFFFFFFF),
    error: Color(0xFFD32F2F),
    background: Color(0xFFF5F5F5),
    onBackground: Color(0xFF424242),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
    secondary: Color(0xFF9E9E9E),
  ),
);

ThemeData natureTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2E7D32),
    onPrimary: Color(0xFFFFFFFF),
    error: Color(0xFFD32F2F),
    background: Color(0xFFE8F5E9),
    onBackground: Color(0xFF2E7D32),
    surface: Color(0xFFFFFDE7),
    onSurface: Color(0xFF212121),
    secondary: Color(0xFF795548),
  ),
);

ThemeData vibrantTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFE91E63),
    onPrimary: Color(0xFFFFFFFF),
    error: Color(0xFFD32F2F),
    background: Color(0xFFFFFDE7),
    onBackground: Color(0xFFE91E63),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
    secondary: Color(0xFF00BCD4),
  ),
);
