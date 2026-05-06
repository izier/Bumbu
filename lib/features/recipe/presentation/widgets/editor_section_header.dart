import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../app/theme/tokens/app_spacing.dart';

class EditorSectionHeader extends StatelessWidget {
  final String title;
  final int? count;
  final String? tooltip;
  final VoidCallback? onAdd;

  const EditorSectionHeader({
    super.key,
    required this.title,
    this.count,
    this.tooltip,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
        if (count != null) ...[
          Text(
            count.toString(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        if (tooltip != null)
          IconButton.filledTonal(
            tooltip: tooltip!,
            onPressed: onAdd,
            icon: const Icon(CupertinoIcons.add),
          ),
      ],
    );
  }
}