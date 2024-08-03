import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildDarkThemeData(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF40BF58), // Green
        textTheme: ButtonTextTheme.primary,
        padding: EdgeInsets.all(0)),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF53134A),
      iconTheme: IconThemeData(color: Colors.white, size: 30),
    ),
    textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 223, 80, 241),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF342E44), // Space cadet
      onPrimaryContainer: Colors.white,
      primaryFixed: Color(0xFF8844F0), // Dark Purple
      primaryFixedDim: Color(0xFF53134A), // matt black
      onPrimaryFixed: Colors.white,
      onPrimaryFixedVariant: Colors.white,

      secondary: Color.fromARGB(255, 101, 247, 196), // accent green
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF40BF58), // Green
      onSecondaryContainer: Colors.white,
      secondaryFixed: Color.fromARGB(255, 64, 191, 88),
      secondaryFixedDim: Color(0xFF1F8762),
      onSecondaryFixed: Colors.white,
      onSecondaryFixedVariant: Colors.white,

      tertiary: Color(0xFFFE7062), // Coral/Orange-Red
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFE7062),
      onTertiaryContainer: Colors.white,
      tertiaryFixed: Color(0xFFFE7062),
      tertiaryFixedDim: Color(0xFFFE7062),
      onTertiaryFixed: Colors.white,
      onTertiaryFixedVariant: Colors.white,

      error: Color(0xFFFE7062), // Coral/Orange-Red
      onError: Colors.white,
      errorContainer: Color(0xFFB00020),
      onErrorContainer: Colors.white,

      surface: Color(0xFF121212),
      onSurface: Colors.white,
      surfaceDim: Color(0xFF1F1F1F),
      surfaceBright: Color(0xFF333333),
      surfaceContainerLowest: Colors.black,
      surfaceContainerLow: Colors.black87,
      surfaceContainer: Colors.white10,
      surfaceContainerHigh: Color(0xFF2C2C2C),
      surfaceContainerHighest: Color(0xFF333333),
      onSurfaceVariant: Colors.white54,

      outline: Color(0xFFCCCCCC),
      outlineVariant: Color(0xFF888888),

      shadow: Colors.black,
      scrim: Colors.black,

      inverseSurface: Color(0xFF333333),
      onInverseSurface: Colors.white,
      inversePrimary: Color(0xFF1F8762), // accent green
      surfaceTint: Color(0xFF40BF58), // Green
    ),
  );
}
