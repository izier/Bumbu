import 'package:bumbu/core/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/theme_extensions.dart';
import '../../domain/entities/ingredient.dart';
import '../state/pantry_provider.dart';

class IngredientItem extends ConsumerWidget {
  final Ingredient ingredient;
  final int index;

  const IngredientItem({
    super.key,
    required this.ingredient,
    required this.index,
  });

  /// 🎨 THEME-DRIVEN COLOR
  Color getColor(BuildContext context) {
    final bumbu = context.bumbu;

    switch (ingredient.confidence) {
      case ConfidenceLevel.high:
        return bumbu.success;
      case ConfidenceLevel.medium:
        return bumbu.warning;
      case ConfidenceLevel.low:
        return bumbu.danger;
    }
  }

  /// 💬 HUMAN LANGUAGE
  String label() {
    switch (ingredient.confidence) {
      case ConfidenceLevel.high:
        return "Still good";
      case ConfidenceLevel.medium:
        return "Use soon";
      case ConfidenceLevel.low:
        return "Going bad";
    }
  }

  /// 🧠 MICRO GUIDANCE
  String hint() {
    switch (ingredient.confidence) {
      case ConfidenceLevel.high:
        return "No rush";
      case ConfidenceLevel.medium:
        return "Best to cook soon";
      case ConfidenceLevel.low:
        return "Use it now or waste it";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = getColor(context);

    return Dismissible(
      key: ValueKey(ingredient.id),

      /// 👉 Swipe to delete
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      onDismissed: (_) {
        ref.read(pantryProvider.notifier).remove(index);
      },

      child: GestureDetector(
        onTap: () {
          final next = ConfidenceLevel.values[
          (ingredient.confidence.index + 1) %
              ConfidenceLevel.values.length];

          ref.read(pantryProvider.notifier).update(ingredient.id, next);
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(18),

            /// ✨ theme-based shadow
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                offset: const Offset(0, 6),
                color: theme.colorScheme.shadow.withValues(alpha: 0.04),
              )
            ],
          ),

          child: Row(
            children: [
              /// 🎯 STATUS INDICATOR
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(width: 12),

              /// 🧾 MAIN CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringUtils.capitalize(ingredient.name),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hint(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),

              /// 🏷️ STATUS CHIP
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  label(),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
