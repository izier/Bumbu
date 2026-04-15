import '../repositories/shopping_repository.dart';

class ClearCheckedItems {
  final ShoppingRepository repository;

  ClearCheckedItems(this.repository);

  Future<void> call() {
    return repository.clearCheked();
  }
}
