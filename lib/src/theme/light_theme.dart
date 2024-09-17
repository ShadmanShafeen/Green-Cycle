import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildLightThemeData(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFBF5840), // Complementary of Green
      textTheme: ButtonTextTheme.primary,
      padding: EdgeInsets.all(0),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF4A5313), // Complementary of Dark Purple
      iconTheme: IconThemeData(color: Colors.black, size: 30),
    ),
    textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
    colorScheme: ColorScheme.light(
      primary: Colors.grey.shade500,
      inversePrimary: Colors.grey.shade900,
      onPrimary: Colors.black,
      primaryContainer: const Color(0xFF44342E), // Complementary of Space cadet
      onPrimaryContainer: Colors.black,
      primaryFixed: const Color(0xFFF08844), // Complementary of Dark Purple
      primaryFixedDim: const Color(0xFF4A5313), // Complementary of matt black
      onPrimaryFixed: Colors.black,
      onPrimaryFixedVariant: Colors.black,

      secondary: Colors.grey.shade200,
      onSecondary: Colors.black,
      secondaryContainer: const Color(0xFFBF5840), // Complementary of Green
      onSecondaryContainer: Colors.black,
      secondaryFixed:
          const Color.fromARGB(255, 191, 64, 88), // Complementary of Green
      secondaryFixedDim:
          const Color(0xFF621F87), // Complementary of accent green
      onSecondaryFixed: Colors.black,
      onSecondaryFixedVariant: Colors.black,

      tertiary: Colors.grey.shade400,
      onTertiary: Colors.black,
      tertiaryContainer: const Color(0xFF62FE70),
      onTertiaryContainer: Colors.black,
      tertiaryFixed: const Color(0xFF62FE70),
      tertiaryFixedDim: const Color(0xFF62FE70),
      onTertiaryFixed: Colors.black,
      onTertiaryFixedVariant: Colors.black,

      error: const Color(0xFF62FE70), // Complementary of Coral/Orange-Red
      onError: Colors.black,
      errorContainer: const Color(0xFF20B000),
      onErrorContainer: Colors.black,

      surface: const Color(0xFFFFFFFF),
      onSurface: Colors.black,
      surfaceDim: const Color(0xFFF1F1F1),
      surfaceBright: const Color(0xFFCCCCCC),
      surfaceContainerLowest: Colors.white70,
      surfaceContainerLow: const Color(0xFFE1E1E1),
      surfaceContainer: Colors.black12,
      surfaceContainerHigh: const Color(0xFFD3D3D3),
      surfaceContainerHighest:
          const Color(0xFFCCCCCC), // Complement of 0xFF333333
      onSurfaceVariant:
          const Color(0xFFABABAB), // Complement of Colors.white54 (0x8AFFFFFF)

      outline: const Color(0xFF333333), // Complement of 0xFFCCCCCC
      outlineVariant: const Color(0xFF777777), // Complement of 0xFF888888
      shadow: Colors.white, // Complement of Colors.black
      scrim: Colors.white, // Complement of Colors.black
      inverseSurface: const Color(0xFFCCCCCC), // Complement of 0xFF333333
      onInverseSurface: const Color(0xFF000000), // Complement of Colors.white
      surfaceTint: const Color(0xFFBF5840), // Complement of 0xFF40BF58 (Green)
    ),
  );
}
