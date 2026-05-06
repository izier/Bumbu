import 'package:flutter/material.dart';

import '../tokens/app_spacing.dart';
import '../tokens/app_radius.dart';

import '../app_decorations.dart';
import '../tokens/app_animations.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_gradients.dart';
import '../tokens/app_shadows.dart';
import '../tokens/app_typography.dart';

//  7a. ANIMATED WIDGET HELPERS
//      Drop-in replacements that bake animation in. All stateless-friendly via
//      AnimatedContainer / TweenAnimationBuilder so no extra State needed.
// ─────────────────────────────────────────────────────────────────────────────

/// Animated food card — lifts on tap with a spring shadow + scale.
/// Usage: wrap any card child instead of a plain GestureDetector.
class AppAnimatedCard extends StatefulWidget {
  const AppAnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.decoration,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BoxDecoration? decoration;

  @override
  State<AppAnimatedCard> createState() => _AppAnimatedCardState();
}

class _AppAnimatedCardState extends State<AppAnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _elevation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: AppAnimations.fast,
      reverseDuration: AppAnimations.base,
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: AppAnimations.standard));
    _elevation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: AppAnimations.standard));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: AnimatedContainer(
            duration: AppAnimations.base,
            curve: AppAnimations.standard,
            decoration: (widget.decoration ?? AppDecorations.foodCard(context))
                .copyWith(
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                            color: Color.lerp(
                              const Color(0x0F000000),
                              const Color(0x22000000),
                              _elevation.value,
                            )!,
                            blurRadius: 16 + 12 * _elevation.value,
                            offset: Offset(0, 4 + 4 * _elevation.value),
                          ),
                        ],
                ),
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

/// Animated bottom nav item — icon scales + color fades on selection.
/// Use inside a custom nav bar instead of raw Icon widgets.
class AppNavItem extends StatelessWidget {
  const AppNavItem({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
    this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: isSelected ? 1.0 : 0.0),
        duration: AppAnimations.base,
        curve: AppAnimations.emphasized,
        builder: (context, t, _) {
          final color = Color.lerp(
            AppColors.navInactive,
            AppColors.navActive,
            t,
          )!;
          final scale = 1.0 + 0.12 * t; // subtle spring-like grow
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: scale,
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  color: color,
                  size: 24,
                ),
              ),
              if (label != null) ...[
                const SizedBox(height: AppSpacing.xs),
                AnimatedDefaultTextStyle(
                  duration: AppAnimations.fast,
                  curve: AppAnimations.standard,
                  style: TextStyle(
                    fontFamily: AppTypography.bodyFont,
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: color,
                  ),
                  child: Text(label!),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// Animated primary button — scales down on press with spring rebound.
class AppAnimatedButton extends StatefulWidget {
  const AppAnimatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  @override
  State<AppAnimatedButton> createState() => _AppAnimatedButtonState();
}

class _AppAnimatedButtonState extends State<AppAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: AppAnimations.fast,
      reverseDuration: const Duration(milliseconds: 300),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _ctrl, curve: AppAnimations.standard));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.isLoading;
    return GestureDetector(
      onTapDown: enabled ? (_) => _ctrl.forward() : null,
      onTapUp: enabled
          ? (_) {
              _ctrl.reverse();
              widget.onPressed!();
            }
          : null,
      onTapCancel: enabled ? () => _ctrl.reverse() : null,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: AppAnimations.base,
          curve: AppAnimations.standard,
          height: 56,
          decoration: BoxDecoration(
            gradient: enabled ? AppGradients.primaryGradient : null,
            color: enabled ? null : const Color(0xFFCCCCCC),
            borderRadius: AppRadius.buttonRadius,
            boxShadow: enabled ? AppShadows.ctaButton : [],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: AppAnimations.fast,
              child: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      key: const ValueKey('label'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, color: Colors.white, size: 20),
                          const SizedBox(width: AppSpacing.sm),
                        ],
                        Text(
                          widget.label,
                          style: AppTypography.buttonLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated category chip — slides background color + scales on select.
class AppAnimatedChip extends StatelessWidget {
  const AppAnimatedChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unselectedBg = isDark
        ? AppColors.surfaceAltDark
        : AppColors.surfaceAlt;
    final unselectedText = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: isSelected ? 1.0 : 0.0),
        duration: AppAnimations.base,
        curve: AppAnimations.emphasized,
        builder: (context, t, _) {
          final bg = Color.lerp(unselectedBg, AppColors.primary, t)!;
          final textColor = Color.lerp(unselectedText, Colors.white, t)!;
          final scale = 1.0 + 0.04 * t;
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: AppRadius.pillRadius,
              ),
              child: Text(
                label,
                style: AppTypography.labelMedium.copyWith(color: textColor),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
