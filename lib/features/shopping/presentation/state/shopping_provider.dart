import 'package:bumbu/features/pantry/data/datasources/pantry_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/shopping_item.dart';

import '../../domain/usecases/get_shopping_items.dart';
import '../../domain/usecases/add_shopping_item.dart';
import '../../domain/usecases/toggle_shopping_item.dart';
import '../../domain/usecases/delete_shopping_item.dart';
import '../../domain/usecases/clear_checked_items.dart';

import '../../data/datasources/shopping_local_datasource.dart';
import '../../data/repositories/shopping_repository_impl.dart';

/// --- Repository Provider ---
final shoppingRepositoryProvider = Provider((ref) {
  return ShoppingRepositoryImpl(
    ShoppingLocalDatasource(),
    PantryLocalDataSource()
  );
});

/// --- UseCases ---
final getShoppingItemsProvider = Provider(
      (ref) => GetShoppingItems(ref.read(shoppingRepositoryProvider)),
);

final addShoppingItemProvider = Provider(
      (ref) => AddShoppingItem(ref.read(shoppingRepositoryProvider)),
);

final toggleShoppingItemProvider = Provider(
      (ref) => ToggleShoppingItem(ref.read(shoppingRepositoryProvider)),
);

final deleteShoppingItemProvider = Provider(
      (ref) => DeleteShoppingItem(ref.read(shoppingRepositoryProvider)),
);

final clearCheckedItemsProvider = Provider(
      (ref) => ClearCheckedItems(ref.read(shoppingRepositoryProvider)),
);

/// --- StateNotifier ---
class ShoppingNotifier extends StateNotifier<List<ShoppingItem>> {
  final Ref ref;

  ShoppingNotifier(this.ref) : super([]);

  Future<void> load() async {
    final items = await ref.read(getShoppingItemsProvider).call();
    state = items;
  }

  Future<void> add(String name) async {
    state = await ref
        .read(addShoppingItemProvider)
        .call(state, name);
  }

  Future<void> toggle(String id) async {
    await ref.read(toggleShoppingItemProvider).call(id);
    await load();
  }

  Future<void> delete(ShoppingItem item) async {
    await ref.read(deleteShoppingItemProvider).call(item);
    await load();
  }

  Future<void> clearChecked() async {
    await ref.read(clearCheckedItemsProvider).call();
    await load();
  }
}

/// --- Main Provider ---
final shoppingProvider =
StateNotifierProvider<ShoppingNotifier, List<ShoppingItem>>(
      (ref) => ShoppingNotifier(ref),
);