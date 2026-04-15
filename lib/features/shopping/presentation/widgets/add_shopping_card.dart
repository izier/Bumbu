import 'package:bumbu/app/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/shopping_provider.dart';

class AddShoppingCard extends ConsumerStatefulWidget {
  final bool expanded;
  final VoidCallback onToggle;

  const AddShoppingCard({
    super.key,
    required this.expanded,
    required this.onToggle,
  });

  @override
  ConsumerState<AddShoppingCard> createState() =>
      _AddShoppingCardState();
}

class _AddShoppingCardState
    extends ConsumerState<AddShoppingCard>
    with SingleTickerProviderStateMixin {
  final controller = TextEditingController();

  void submit() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    ref.read(shoppingProvider.notifier).add(text);
    controller.clear();

    widget.onToggle();
  }

  void quickAdd(String value) {
    ref.read(shoppingProvider.notifier).add(value);

    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🧠 HEADER TEXT (Emotion)
          Text(
            widget.expanded
                ? "What do you want to buy?"
                : "Add something to your shopping list",
            style: theme.textTheme.titleLarge,
          ),

          const SizedBox(height: 6),

          Text(
            widget.expanded
                ? "We’ll add it to your pantry automatically"
                : "Start with one ingredient",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),

          const SizedBox(height: 16),

          /// ✨ INPUT AREA
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: widget.expanded ? _buildInput(theme, context) : _buildCollapsed(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsed(ThemeData theme) {
    return GestureDetector(
      onTap: widget.onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(Icons.add, color: theme.colorScheme.primary),
            const SizedBox(width: 10),
            Text(
              "Add ingredient",
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(ThemeData theme, BuildContext context) {
    final bumbu = context.bumbu;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: bumbu.surfaceSoft,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// ✏️ INPUT
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: "e.g. eggs, rice, chicken...",
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// ✅ ACTION BUTTON (INTEGRATED)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: submit,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _quickChip("Eggs"),
                _quickChip("Rice"),
                _quickChip("Chicken"),
                _quickChip("Onion"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickChip(String label) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => quickAdd(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
