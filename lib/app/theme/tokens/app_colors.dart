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
  static const Color bgLight = Color(0xFFF2F2F7); // systemGroupedBackground
  static const Color surfaceLight = Color(0xFFFFFFFF); // systemBackground
  static const Color surfaceAlt = Color(0xFFE5E5EA); // systemGray6
  static const Color cardLight = Color(0xFFFFFFFF); // secondarySystemGroupedBackground
  static const Color dividerLight = Color(0xFFC6C6C8); // separator
  static const Color shimmerBase = Color(0xFFE5E5EA);
  static const Color shimmerHighlight = Color(0xFFF2F2F7);

  // ── Neutrals — Dark Mode ──────────────────────────────────────────────────
  static const Color bgDark = Color(0xFF000000); // systemBackground (dark)
  static const Color surfaceDark = Color(0xFF1C1C1E); // secondarySystemBackground
  static const Color surfaceAltDark = Color(0xFF2C2C2E); // tertiarySystemBackground
  static const Color cardDark = Color(0xFF1C1C1E);
  static const Color dividerDark = Color(0xFF38383A); // separator (dark)

  // ── Text — Light Mode ─────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF000000); // label
  static const Color textSecondary = Color(0xFF3C3C43); // secondaryLabel (approx)
  static const Color textTertiary = Color(0xFF3C3C43); // placeholderText is 30% black approx
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ── Text — Dark Mode ──────────────────────────────────────────────────────
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // label
  static const Color textSecondaryDark = Color(0xFFEBEBF5); // secondaryLabel (approx)
  static const Color textTertiaryDark = Color(0xFFEBEBF5); // tertiaryLabel

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
