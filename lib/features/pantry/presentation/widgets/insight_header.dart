import 'package:flutter/material.dart';
import '../../../../app/theme/theme_extensions.dart';
import '../../domain/entities/ingredient.dart';

class InsightHeader extends StatelessWidget {
  final List<Ingredient> items;

  const InsightHeader({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bumbu = context.bumbu;

    final high =
        items.where((e) => e.confidence == ConfidenceLevel.high).length;
    final medium =
        items.where((e) => e.confidence == ConfidenceLevel.medium).length;
    final low =
        items.where((e) => e.confidence == ConfidenceLevel.low).length;

    final total = items.length;

    /// 🧠 STATE LOGIC
    String title;
    String subtitle;
    Color accent;

    if (items.isEmpty) {
      title = "Your kitchen is waiting";
      subtitle = "Add ingredients and we’ll guide you to a meal";
      accent = theme.colorScheme.primary;
    } else if (low > 0) {
      title = "Use these soon";
      subtitle = "$low ingredient${low > 1 ? 's are' : ' is'} about to go bad";
      accent = bumbu.danger;
    } else if (high > total * 0.6) {
      title = "You're ready to cook";
      subtitle = "You’ve got a solid base to start";
      accent = bumbu.success;
    } else {
      title = "Almost there";
      subtitle = "A few more ingredients and you're set";
      accent = bumbu.warning;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 8),
            color: theme.colorScheme.shadow.withValues(alpha: 0.04),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🎯 TITLE + ACCENT DOT
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// 💬 SUBTITLE
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),

          const SizedBox(height: 14),

          /// 📊 CONFIDENCE BAR
          _ConfidenceBar(
            high: high,
            medium: medium,
            low: low,
            total: total,
          ),

          const SizedBox(height: 12),

          /// 🧾 META INFO
          Text(
            "$total items · $high ready",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfidenceBar extends StatelessWidget {
  final int high;
  final int medium;
  final int low;
  final int total;

  const _ConfidenceBar({
    required this.high,
    required this.medium,
    required this.low,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final bumbu = context.bumbu;
    final theme = Theme.of(context);

    if (total == 0) {
      return Container(
        height: 6,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    final highFlex = (high / total * 100).round();
    final mediumFlex = (medium / total * 100).round();
    final lowFlex = (low / total * 100).round();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          if (high > 0)
            Expanded(
              flex: highFlex,
              child: Container(
                height: 6,
                color: bumbu.success,
              ),
            ),
          if (medium > 0)
            Expanded(
              flex: mediumFlex,
              child: Container(
                height: 6,
                color: bumbu.warning,
              ),
            ),
          if (low > 0)
            Expanded(
              flex: lowFlex,
              child: Container(
                height: 6,
                color: bumbu.danger,
              ),
            ),
        ],
      ),
    );
  }
}
