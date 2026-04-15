import 'package:bumbu/app/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/string_utils.dart';
import '../../domain/entities/shopping_item.dart';
import '../state/shopping_provider.dart';

class ShoppingItemTile extends ConsumerWidget {
  final ShoppingItem item;
  final int index;

  const ShoppingItemTile({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        ref.read(shoppingProvider.notifier).delete(item);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () =>
            ref.read(shoppingProvider.notifier).toggle(item.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: item.isChecked
                ? Colors.grey.shade200
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                  color: item.isChecked
                      ? context.bumbu.success
                      : Colors.transparent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  StringUtils.capitalize(item.name),
                  style: TextStyle(
                    fontSize: 16,
                    decoration: item.isChecked
                        ? TextDecoration.lineThrough
                        : null,
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