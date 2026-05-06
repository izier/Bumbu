import 'dart:ui';
import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  /// The total vertical space the floating bar occupies.
  /// Use this to pad scrollable content so nothing hides behind it.
  static double totalHeight(BuildContext context) =>
      64.0 + 24.0 + MediaQuery.of(context).padding.bottom;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Glass tint: pulls from your navBgLight / navBg tokens via the theme
    // surface is the closest semantic match for a frosted container
    final bgColor = isDark
        ? theme.colorScheme.surface.withValues(alpha: 0.55)
        : theme.colorScheme.surface.withValues(alpha: 0.72);

    final borderColor = isDark
        ? theme.colorScheme.outlineVariant.withValues(alpha: 0.15)
        : theme.colorScheme.outlineVariant.withValues(alpha: 0.90);

    final shadowColor = theme.colorScheme.shadow.withValues(alpha: isDark ? 0.40 : 0.08);

    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: borderColor, width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
              items: items,
            ),
          ),
        ),
      ),
    );
  }
}