import '../entities/shopping_item.dart';
import '../repositories/shopping_repository.dart';

class GetShoppingItems {
  final ShoppingRepository repository;

  GetShoppingItems(this.repository);

  Future<List<ShoppingItem>> call() {
    return repository.getShoppingList();
  }
}
