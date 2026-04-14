// lib/app/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    extensions: [
      const AppColors(
        success: Color(0xFF3BB273),
        warning: Color(0xFFFFB020),
        danger: Color(0xFFFF5A5A),
        surfaceSoft: Color(0xFFFFF1EE),
        surfaceMuted: Color(0xFFF5F5F5),
      )
    ],

    // 🌈 COLOR SCHEME
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xFFFF3B3B),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFFF6B6B),
      onPrimaryContainer: Colors.white,

      secondary: const Color(0xFFFF8A65),
      onSecondary: Colors.white,

      error: const Color(0xFFFF5A5A),
      onError: Colors.white,

      surface: Colors.white,
      onSurface: const Color(0xFF1A1A1A),
    ),

    scaffoldBackgroundColor: const Color(0xFFFFF8F6),

    // 🔤 TYPOGRAPHY (PLUS JAKARTA SANS)
      textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),

    // 🧱 APP BAR
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
      titleTextStyle: TextStyle(
        color: Color(0xFF1A1A1A),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // 🔘 BUTTONS
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF3B3B),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),

    // ✨ CARD (SOFT, FRIENDLY)
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // 📦 INPUT FIELDS
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFF1EE),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(
        color: Color(0xFFA0A0A0),
      ),
    ),

    // 🧭 BOTTOM NAV (important for BUMBU)
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFFF3B3B),
      unselectedItemColor: Color(0xFF9E9E9E),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // 🧩 CHIP (used for ingredients / tags)
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFFFF1EE),
      selectedColor: const Color(0xFFFF3B3B),
      labelStyle: const TextStyle(
        color: Color(0xFF1A1A1A),
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // 🎭 DIVIDER (soft separation)
    dividerTheme: DividerThemeData(
      color: Colors.grey.withValues(alpha: 0.2),
      thickness: 1,
    ),
  );
}
