import 'package:flutter/material.dart';

import 'tokens/app_colors.dart';
import 'tokens/app_gradients.dart';
import 'tokens/app_radius.dart';
import 'tokens/app_shadows.dart';

//  10. COMPONENT STYLE HELPERS
//     Reusable decoration & style factories for food-specific UI patterns
// ─────────────────────────────────────────────────────────────────────────────

class AppDecorations {
  AppDecorations._();

  // ── Food Card (hero photo card with rounded corners) ─────────────────────
  // Usage: AppDecorations.foodCard(context)
  static BoxDecoration foodCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? AppColors.cardDark : AppColors.cardLight,
      borderRadius: AppRadius.cardRadius,
      boxShadow: isDark ? [] : AppShadows.card,
    );
  }

  // ── Category Chip (selected) ──────────────────────────────────────────────
  static const BoxDecoration categoryChipSelected = BoxDecoration(
    color: AppColors.primary,
    borderRadius: AppRadius.pillRadius,
  );

  // ── Category Chip (unselected) ────────────────────────────────────────────
  static BoxDecoration categoryChipDefault(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? AppColors.surfaceAltDark : AppColors.surfaceAlt,
      borderRadius: AppRadius.pillRadius,
    );
  }

  // ── Promo Banner ──────────────────────────────────────────────────────────
  static const BoxDecoration promoBanner = BoxDecoration(
    gradient: AppGradients.primaryGradient,
    borderRadius: AppRadius.cardRadius,
  );

  // ── Rating Badge ──────────────────────────────────────────────────────────
  static BoxDecoration ratingBadge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
          .withValues(alpha: 0.9),
      borderRadius: AppRadius.chipRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // ── Search Bar ────────────────────────────────────────────────────────────
  static BoxDecoration searchBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? AppColors.surfaceAltDark : AppColors.surfaceAlt,
      borderRadius: AppRadius.inputRadius,
    );
  }

  // ── Bottom Nav Panel (theme-aware) ───────────────────────────────────────
  static BoxDecoration navPanel(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? AppColors.navBg : AppColors.navBgLight,
      boxShadow: AppShadows.navBar,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
    );
  }

  // ── Quantity Stepper ──────────────────────────────────────────────────────
  static BoxDecoration quantityStepper(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark
          ? AppColors.primaryDarker.withValues(alpha: 0.3)
          : AppColors.primarySurface,
      borderRadius: AppRadius.pillRadius,
    );
  }

  // ── Order Status Badge ────────────────────────────────────────────────────
  static BoxDecoration statusBadge(Color color) => BoxDecoration(
    color: color.withValues(alpha: 0.12),
    borderRadius: AppRadius.pillRadius,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
