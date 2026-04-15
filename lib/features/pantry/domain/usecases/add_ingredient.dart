import '../../../../core/utils/string_utils.dart';
import '../entities/ingredient.dart';
import '../repositories/pantry_repository.dart';
import '../services/pantry_engine.dart';

class AddIngredient {
  final PantryRepository repository;

  AddIngredient(this.repository);

  Future<List<Ingredient>> call(
      List<Ingredient> current, String name) async {

    final normalized = StringUtils.normalize(name);

    final exists = current.any((e) => e.name == normalized);

    if (exists) return current;

    final newItem = PantryEngine.createIngredient(name);

    final updated = [...current, newItem];

    await repository.savePantry(updated);

    return updated;
  }
}
