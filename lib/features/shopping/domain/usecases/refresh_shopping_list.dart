import '../entities/shopping_item.dart';
import '../services/shopping_engine.dart';

class RefreshShoppingList {
  List<ShoppingItem> call(List<ShoppingItem> items) {
    return ShoppingEngine.refreshShoppingList(items);
  }
}
