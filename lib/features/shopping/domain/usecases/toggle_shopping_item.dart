import '../repositories/shopping_repository.dart';

class ToggleShoppingItem {
  final ShoppingRepository repository;

  ToggleShoppingItem(this.repository);

  Future<void> call(String id) {
    return repository.toggleItem(id);
  }
}
