import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;

import '../../../../../app/theme/tokens/app_spacing.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../home/presentation/widgets/recipe_card.dart';
import '../../domain/entities/ingredient.dart';
import '../../domain/entities/step.dart';

// ── Tile builders ────────────────────────────────────────────────────────────

List<Widget> buildIngredientTiles({
  required BuildContext context,
  required AppLocalizations t,
  required List<Ingredient> ingredients,
  required ValueChanged<int> onRemove,
  required ValueChanged<int> onEdit,
}) {
  if (ingredients.isEmpty) return [EditorEmptyState(label: t.noIngredients)];

  final tiles = <Widget>[];
  for (var i = 0; i < ingredients.length; i++) {
    if (i > 0) tiles.add(const SizedBox(height: AppSpacing.sm));
    tiles.add(
      EditorTile(
        title: ingredients[i].displayName,
        tooltip: t.removeIngredient,
        onRemove: () => onRemove(i),
        onTap: () => onEdit(i),
      ),
    );
  }
  return tiles;
}

List<Widget> buildStepTiles({
  required BuildContext context,
  required AppLocalizations t,
  required List<Step> steps,
  required ValueChanged<int> onRemove,
  required ValueChanged<int> onEdit,
}) {
  if (steps.isEmpty) return [EditorEmptyState(label: t.noSteps)];

  final tiles = <Widget>[];
  for (var i = 0; i < steps.length; i++) {
    final step = steps[i];
    if (i > 0) tiles.add(const SizedBox(height: AppSpacing.sm));
    tiles.add(
      EditorTile(
        title: '${step.index + 1}. ${step.instruction}',
        subtitle: step.duration == null
            ? null
            : friendlyDurationLabel(t, Duration(seconds: step.duration!)),
        tooltip: t.removeStep,
        onRemove: () => onRemove(i),
        onTap: () => onEdit(i),
      ),
    );
  }
  return tiles;
}

// ── EditorTile ───────────────────────────────────────────────────────────────

class EditorTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String tooltip;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  const EditorTile({
    super.key,
    required this.title,
    required this.tooltip,
    required this.onRemove,
    this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.xs,
        ),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: IconButton(
          tooltip: tooltip,
          onPressed: onRemove,
          icon: const Icon(CupertinoIcons.delete),
        ),
      ),
    );
  }
}

// ── EditorEmptyState ─────────────────────────────────────────────────────────

class EditorEmptyState extends StatelessWidget {
  final String label;

  const EditorEmptyState({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
