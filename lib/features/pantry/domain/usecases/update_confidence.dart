// usecases/update_confidence.dart

import '../entities/ingredient.dart';
import '../repositories/pantry_repository.dart';
import '../services/pantry_engine.dart';

class UpdateConfidence {
  final PantryRepository repository;

  UpdateConfidence(this.repository);

  Future<List<Ingredient>> call(
      List<Ingredient> current,
      String id,
      ConfidenceLevel level,
      ) async {
    final updated = current.map((item) {
      if (item.id == id) {
        return PantryEngine.updateConfidence(item, level);
      }
      return item;
    }).toList();

    await repository.savePantry(updated);
    return updated;
  }
}
