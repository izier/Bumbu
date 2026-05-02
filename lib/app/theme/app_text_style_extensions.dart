import 'package:flutter/material.dart';

import 'tokens/app_colors.dart';

//  11. TEXT STYLE EXTENSIONS
//      Convenient color overrides for dark surfaces / overlays
// ─────────────────────────────────────────────────────────────────────────────

extension AppTextStyleX on TextStyle {
  TextStyle get onDark => copyWith(color: Colors.white);
  TextStyle get onPrimary => copyWith(color: Colors.white);
  TextStyle get muted => copyWith(color: AppColors.textSecondary);
  TextStyle get red => copyWith(color: AppColors.primary);
  TextStyle get amber => copyWith(color: AppColors.secondary);
  TextStyle get success => copyWith(color: AppColors.success);
}

// ─────────────────────────────────────────────────────────────────────────────
