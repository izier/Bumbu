import 'app_colors.dart';
import 'package:flutter/material.dart';

extension BumbuThemeX on BuildContext {
  AppColors get bumbu =>
      Theme.of(this).extension<AppColors>()!;
}
