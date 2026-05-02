import 'package:flutter/material.dart';

import 'tokens/app_colors.dart';

//  12. THEME EXTENSION — Custom tokens via ThemeExtension
// ─────────────────────────────────────────────────────────────────────────────

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.cardColor,
    required this.surfaceAltColor,
    required this.starColor,
    required this.priceColor,
    required this.tagBg,
    required this.tagText,
    required this.deliveryBadgeBg,
    required this.deliveryBadgeText,
  });

  final Color cardColor;
  final Color surfaceAltColor;
  final Color starColor;
  final Color priceColor;
  final Color tagBg;
  final Color tagText;
  final Color deliveryBadgeBg;
  final Color deliveryBadgeText;

  static const light = AppThemeExtension(
    cardColor: AppColors.cardLight,
    surfaceAltColor: AppColors.surfaceAlt,
    starColor: AppColors.star,
    priceColor: AppColors.primary,
    tagBg: AppColors.surfaceAlt,
    tagText: AppColors.textSecondary,
    deliveryBadgeBg: AppColors.successSurface,
    deliveryBadgeText: AppColors.success,
  );

  static const dark = AppThemeExtension(
    cardColor: AppColors.cardDark,
    surfaceAltColor: AppColors.surfaceAltDark,
    starColor: AppColors.star,
    priceColor: AppColors.primary,
    tagBg: AppColors.surfaceAltDark,
    tagText: AppColors.textSecondaryDark,
    deliveryBadgeBg: Color(0xFF1A3D2B),
    deliveryBadgeText: AppColors.success,
  );

  @override
  AppThemeExtension copyWith({
    Color? cardColor,
    Color? surfaceAltColor,
    Color? starColor,
    Color? priceColor,
    Color? tagBg,
    Color? tagText,
    Color? deliveryBadgeBg,
    Color? deliveryBadgeText,
  }) {
    return AppThemeExtension(
      cardColor: cardColor ?? this.cardColor,
      surfaceAltColor: surfaceAltColor ?? this.surfaceAltColor,
      starColor: starColor ?? this.starColor,
      priceColor: priceColor ?? this.priceColor,
      tagBg: tagBg ?? this.tagBg,
      tagText: tagText ?? this.tagText,
      deliveryBadgeBg: deliveryBadgeBg ?? this.deliveryBadgeBg,
      deliveryBadgeText: deliveryBadgeText ?? this.deliveryBadgeText,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      surfaceAltColor: Color.lerp(surfaceAltColor, other.surfaceAltColor, t)!,
      starColor: Color.lerp(starColor, other.starColor, t)!,
      priceColor: Color.lerp(priceColor, other.priceColor, t)!,
      tagBg: Color.lerp(tagBg, other.tagBg, t)!,
      tagText: Color.lerp(tagText, other.tagText, t)!,
      deliveryBadgeBg: Color.lerp(deliveryBadgeBg, other.deliveryBadgeBg, t)!,
      deliveryBadgeText: Color.lerp(
        deliveryBadgeText,
        other.deliveryBadgeText,
        t,
      )!,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
