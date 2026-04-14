import 'package:flutter/material.dart';
import '../../../../app/theme/theme_extensions.dart';
import '../../domain/entities/ingredient.dart';

class StatsRow extends StatelessWidget {
  final List<Ingredient> ingredients;

  const StatsRow({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final bumbu = context.bumbu;

    final high = ingredients
        .where((e) => e.confidence == ConfidenceLevel.high)
        .length;
    final low = ingredients
        .where((e) => e.confidence == ConfidenceLevel.low)
        .length;

    return Row(
      children: [
        _pulseCard(
          context,
          value: "$high",
          label: "Ready to cook",
          color: bumbu.success,
          icon: Icons.check_circle_rounded,
        ),
        const SizedBox(width: 10),
        _pulseCard(
          context,
          value: "$low",
          label: "Use soon",
          color: bumbu.warning,
          icon: Icons.warning_rounded,
        ),
      ],
    );
  }

  Widget _pulseCard(
      BuildContext context, {
        required String value,
        required String label,
        required Color color,
        required IconData icon,
      }) {
    final theme = Theme.of(context);

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              offset: const Offset(0, 6),
              color: Colors.black.withValues(alpha: 0.04),
            )
          ],
        ),

        child: Row(
          children: [
            /// 🎯 ICON (quick emotional signal)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),

            const SizedBox(width: 12),

            /// 🧾 TEXT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                    theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
