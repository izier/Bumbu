import 'package:flutter/material.dart';

//  2. TYPOGRAPHY (Apple HIG Inspired)
// ─────────────────────────────────────────────────────────────────────────────

class AppTypography {
  AppTypography._();

  // Use system fonts for best HIG compliance
  static const String displayFont = 'Plus Jakarta Sans'; // Bold headers
  static const String bodyFont = 'Inter'; // UI / body copy

  // ── Display / Hero (iOS Large Title) ──────────────────────────────────────
  static const TextStyle heroTitle = TextStyle(
    fontFamily: displayFont,
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.37,
    height: 1.2,
  );

  static const TextStyle heroTitleLight = TextStyle(
    fontFamily: displayFont,
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.37,
    height: 1.2,
  );

  // ── Section Headings (iOS Titles) ─────────────────────────────────────────
  static const TextStyle h1 = TextStyle(
    fontFamily: displayFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.36,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: displayFont,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.35,
    height: 1.25,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: displayFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.38,
    height: 1.3,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: bodyFont,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    height: 1.35,
  );

  // ── Body ──────────────────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: bodyFont,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    height: 1.3,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: bodyFont,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.24,
    height: 1.35,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: bodyFont,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.08,
    height: 1.4,
  );

  // ── Labels / UI ───────────────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: bodyFont,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: bodyFont,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.24,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: bodyFont,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.08,
  );

  // ── Button ────────────────────────────────────────────────────────────────
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: bodyFont,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: bodyFont,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.24,
  );

  // ── Caption / Tag ─────────────────────────────────────────────────────────
  static const TextStyle caption = TextStyle(
    fontFamily: bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
  );

  static const TextStyle tag = TextStyle(
    fontFamily: bodyFont,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.06,
  );
}
