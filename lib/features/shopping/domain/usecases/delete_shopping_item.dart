import '../entities/shopping_item.dart';
import '../repositories/shopping_repository.dart';

class DeleteShoppingItem {
  final ShoppingRepository repository;

  DeleteShoppingItem(this.repository);

  Future<void> call(ShoppingItem item) {
    return repository.deleteItem(item);
  }
}
