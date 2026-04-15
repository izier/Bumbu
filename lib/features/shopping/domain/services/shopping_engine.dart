import '../entities/shopping_item.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../core/services/id_generator.dart';

class ShoppingEngine {
  static ShoppingItem addItem(String name) {
    return ShoppingItem(
      id: IdGenerator.generate(),
      name: StringUtils.normalize(name),
      quantity: '',
      isChecked: false,
      category: '',
    );
  }

  static List<ShoppingItem> refreshShoppingList(List<ShoppingItem> items) {
    return items;
  }
}
