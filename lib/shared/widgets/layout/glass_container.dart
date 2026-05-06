import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../app/theme/tokens/app_radius.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double blur;
  final double opacity;
  final Color? color;
  final BoxBorder? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.blur = 24.0,
    this.opacity = 0.65,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final effectiveBorderRadius = borderRadius ?? AppRadius.cardRadius;
    
    final effectiveColor = color ?? (isDark
        ? theme.colorScheme.surface.withValues(alpha: 0.55)
        : theme.colorScheme.surface.withValues(alpha: 0.72));

    final borderColor = isDark
        ? theme.colorScheme.outlineVariant.withValues(alpha: 0.15)
        : theme.colorScheme.outlineVariant.withValues(alpha: 0.80);

    final shadowColor = theme.colorScheme.shadow.withValues(alpha: isDark ? 0.40 : 0.08);

    return Container(
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: effectiveBorderRadius,
              border: border ?? Border.all(color: borderColor, width: 0.8),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
