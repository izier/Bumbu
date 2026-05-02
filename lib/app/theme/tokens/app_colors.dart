import 'package:flutter/material.dart';

//  1. COLOR PALETTE
// ─────────────────────────────────────────────────────────────────────────────

class AppColors {
  AppColors._();

  // ── Primary Brand (Logo Red) ──────────────────────────────────────────────
  static const Color primary = Color(0xFFFF383C);
  static const Color primaryLight = Color(0xFFFF6B6E);
  static const Color primaryLighter = Color(0xFFFFD6D7);
  static const Color primaryDark = Color(0xFFCC1E22);
  static const Color primaryDarker = Color(0xFF99060A);
  static const Color primarySurface = Color(0xFFFFF0F0); // card tint bg

  // ── Secondary Accent (Warm Amber — ratings, badges) ───────────────────────
  static const Color secondary = Color(0xFFFF8C00);
  static const Color secondaryLight = Color(0xFFFFB84D);
  static const Color secondaryDark = Color(0xFFCC7000);

  // ── Neutrals — Light Mode ─────────────────────────────────────────────────
  static const Color bgLight = Color(0xFFF8F7F5); // warm off-white
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF2F1EE); // chip / tag bg
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFEAE9E5);
  static const Color shimmerBase = Color(0xFFEDECE9);
  static const Color shimmerHighlight = Color(0xFFF8F7F5);

  // ── Neutrals — Dark Mode ──────────────────────────────────────────────────
  static const Color bgDark = Color(0xFF111111);
  static const Color surfaceDark = Color(0xFF1C1C1C);
  static const Color surfaceAltDark = Color(0xFF2A2A2A);
  static const Color cardDark = Color(0xFF222222);
  static const Color dividerDark = Color(0xFF303030);

  // ── Text — Light Mode ─────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F0F0F); // near-black
  static const Color textSecondary = Color(0xFF6B6460);
  static const Color textTertiary = Color(0xFFABA5A0);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ── Text — Dark Mode ──────────────────────────────────────────────────────
  static const Color textPrimaryDark = Color(0xFFF2F0ED);
  static const Color textSecondaryDark = Color(0xFFABA5A0);
  static const Color textTertiaryDark = Color(0xFF6B6460);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF2DB66B);
  static const Color successSurface = Color(0xFFEAF7F0);
  static const Color warning = Color(0xFFFFB800);
  static const Color warningSurface = Color(0xFFFFF8E6);
  static const Color error = Color(0xFFFF383C); // same as primary
  static const Color errorSurface = Color(0xFFFFF0F0);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoSurface = Color(0xFFEFF6FF);

  // ── Rating Star ───────────────────────────────────────────────────────────
  static const Color star = Color(0xFFFFB800);

  // ── Overlay / Gradient ───────────────────────────────────────────────────
  static const Color overlayDark = Color(0xCC000000); // 80% black
  static const Color overlayMid = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x33000000); // 20% black

  // ── Bottom Nav ────────────────────────────────────────────────────────────
  static const Color navBg = Color(0xFF1A1A1A); // dark mode
  static const Color navBgLight = Color(0xFFFFFFFF); // light mode
  static const Color navActive = Color(0xFFFF383C);
  static const Color navInactive = Color(0xFF6B6460);
}

// ─────────────────────────────────────────────────────────────────────────────
