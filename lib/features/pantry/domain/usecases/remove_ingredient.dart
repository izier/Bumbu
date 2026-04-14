// usecases/remove_ingredient.dart

import '../entities/ingredient.dart';
import '../repositories/pantry_repository.dart';

class RemoveIngredient {
  final PantryRepository repository;

  RemoveIngredient(this.repository);

  Future<List<Ingredient>> call(
      List<Ingredient> current, int index) async {
    final updated = [...current]..removeAt(index);

    await repository.savePantry(updated);

    return updated;
  }
}
