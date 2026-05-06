import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/tokens/app_colors.dart';
import '../../../../app/theme/tokens/app_radius.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../recipe/domain/entities/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;

  const RecipeCard({super.key, required this.recipe, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    final accentColor = _accentFor(recipe.id);
    final duration = recipeTotalDurationLabel(t, recipe);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  CupertinoIcons.flame_fill,
                  color: accentColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: AppSpacing.base),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      recipe.description.isEmpty
                          ? _ingredientCountLabel(t, recipe.ingredients.length)
                          : recipe.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        if (duration != null)
                          _Metric(icon: CupertinoIcons.timer, label: duration),
                        _Metric(
                          icon: CupertinoIcons.person_2,
                          label: _servingCountLabel(t, recipe.servings),
                        ),
                        _Metric(
                          icon: CupertinoIcons.square_list,
                          label: _itemCountLabel(t, recipe.ingredients.length),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                CupertinoIcons.chevron_forward,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? recipeTotalDurationLabel(AppLocalizations t, Recipe recipe) {
  final seconds = recipe.steps.fold<int>(
    0,
    (total, step) => total + (step.duration ?? 0),
  );
  if (seconds <= 0) return null;
  return friendlyDurationLabel(t, Duration(seconds: seconds));
}

String friendlyDurationLabel(AppLocalizations t, Duration duration) {
  final seconds = duration.inSeconds;
  if (seconds < 60) {
    return seconds == 1 ? t.secondCountOne : t.secondCountOther(seconds);
  }

  final minutes = (seconds / 60).round();
  if (minutes < 60) {
    return minutes == 1 ? t.minuteCountOne : t.minuteCountOther(minutes);
  }

  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;
  if (hours < 24) {
    final h = hours == 1 ? t.hourCountOne : t.hourCountOther(hours);
    if (remainingMinutes == 0) return h;
    final m = remainingMinutes == 1
        ? t.minuteCountOne
        : t.minuteCountOther(remainingMinutes);
    return '$h $m';
  }

  final days = hours ~/ 24;
  final remainingHours = hours % 24;
  final d = days == 1 ? t.dayCountOne : t.dayCountOther(days);
  if (remainingHours == 0) return d;
  final rh =
      remainingHours == 1 ? t.hourCountOne : t.hourCountOther(remainingHours);
  return '$d $rh';
}

String _ingredientCountLabel(AppLocalizations t, int n) =>
    n == 1 ? t.ingredientCountOne : t.ingredientCountOther(n);

String _servingCountLabel(AppLocalizations t, int n) =>
    n == 1 ? t.servingCountOne : t.servingCountOther(n);

String _itemCountLabel(AppLocalizations t, int n) =>
    n == 1 ? t.itemCountOne : t.itemCountOther(n);

Color _accentFor(String seed) {
  const colors = [
    Color(0xFFFFB84D),
    Color(0xFF2DB66B),
    Color(0xFF3B82F6),
    Color(0xFFFF383C),
    Color(0xFF8B5CF6),
    Color(0xFF06B6D4),
  ];

  final codeUnits = seed.isEmpty ? [0] : seed.codeUnits;
  final hash = codeUnits.fold<int>(0, (value, unit) => value + unit);
  return colors[hash % colors.length];
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Metric({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
