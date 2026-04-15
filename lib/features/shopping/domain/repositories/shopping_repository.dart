import '../entities/shopping_item.dart';

abstract class ShoppingRepository {
  Future<List<ShoppingItem>> getShoppingList();
  Future<void> toggleItem(String id);
  Future<void> deleteItem(ShoppingItem item);
  Future<void> clearCheked();
  Future<void> saveShoppingList(List<ShoppingItem> items);
}
