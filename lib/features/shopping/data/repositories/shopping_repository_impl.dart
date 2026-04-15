import 'package:bumbu/features/pantry/data/datasources/pantry_local_datasource.dart';

import '../../domain/entities/shopping_item.dart';
import '../datasources/shopping_local_datasource.dart';
import '../models/shopping_item_model.dart';
import '../../domain/repositories/shopping_repository.dart';

class ShoppingRepositoryImpl implements ShoppingRepository {
  final ShoppingLocalDatasource localDataSource;
  final PantryLocalDataSource pantryLocalDataSource;

  ShoppingRepositoryImpl(
    this.localDataSource,
    this.pantryLocalDataSource
  );

  @override
  Future<List<ShoppingItem>> getShoppingList() async {
    final models = await localDataSource.loadShoppingList();

    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveShoppingList(List<ShoppingItem> items) async {
    final models =
    items.map((e) => ShoppingItemModel.fromEntity(e)).toList();

    await localDataSource.saveShoppingList(models);
  }

  @override
  Future<void> clearCheked() async {
    final models = await localDataSource.loadShoppingList();

    final updated = models.where((item) => !item.isChecked).toList();

    await localDataSource.saveShoppingList(updated);
  }

  @override
  Future<void> deleteItem(ShoppingItem item) async {
    final models = await localDataSource.loadShoppingList();

    final updated = models.where((e) => e.id != item.id).toList();

    await localDataSource.saveShoppingList(updated);
  }

  @override
  Future<void> toggleItem(String id) async {
    final models = await localDataSource.loadShoppingList();

    final List<ShoppingItemModel> updated = models.map((item) {
      if (item.id == id) {
        return item.copyWith(isChecked: !item.isChecked);
      }
      return item;
    }).toList();

    await localDataSource.saveShoppingList(updated);
  }
}