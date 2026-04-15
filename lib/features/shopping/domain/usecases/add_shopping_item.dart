import '../../../../core/utils/string_utils.dart';
import '../entities/shopping_item.dart';
import '../repositories/shopping_repository.dart';
import '../services/shopping_engine.dart';

class AddShoppingItem {
  final ShoppingRepository repository;

  AddShoppingItem(this.repository);

  Future<List<ShoppingItem>> call(
      List<ShoppingItem> current, String name) async {

    final normalized = StringUtils.normalize(name);

    final exists = current.any((e) => e.name == normalized);

    if (exists) return current;

    final newItem = ShoppingEngine.addItem(name);

    final updated = [...current, newItem];

    await repository.saveShoppingList(updated);

    return updated;
  }
}
