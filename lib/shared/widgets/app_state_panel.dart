import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme/tokens/app_radius.dart';
import '../../app/theme/tokens/app_spacing.dart';

class AppStatePanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;
  final bool compact;
  final Color? color;
  final Color? iconColor;

  const AppStatePanel({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
    this.compact = false,
    this.color,
    this.iconColor,
  });

  const AppStatePanel.loading({
    super.key,
    required this.title,
    this.message,
    this.compact = true,
  }) : icon = CupertinoIcons.hourglass,
       action = null,
       color = null,
       iconColor = null;

  const AppStatePanel.error({
    super.key,
    required this.title,
    this.message,
    this.compact = true,
  }) : icon = CupertinoIcons.exclamationmark_circle,
       action = null,
       color = null,
       iconColor = null;

  bool get _isLoading => icon == CupertinoIcons.hourglass;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final alignStart = compact && !_isLoading;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.cardRadius,
        color: color ?? theme.colorScheme.surfaceContainerHighest,
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.base : AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              alignStart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            if (_isLoading)
              const CupertinoActivityIndicator()
            else
              Icon(
                icon,
                size: 30,
                color: iconColor ?? theme.colorScheme.onSurfaceVariant,
              ),
            if (title.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                textAlign: alignStart ? TextAlign.start : TextAlign.center,
                style: theme.textTheme.titleSmall,
              ),
            ],
            if (message != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                message!,
                textAlign: alignStart ? TextAlign.start : TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.base),
              if (compact) action! else Center(child: action!),
            ],
          ],
        ),
      ),
    );
  }
}
