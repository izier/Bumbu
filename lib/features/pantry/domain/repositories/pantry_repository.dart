// features/pantry/domain/repositories/pantry_repository.dart

import '../entities/ingredient.dart';

abstract class PantryRepository {
  Future<List<Ingredient>> getPantry();
  Future<void> savePantry(List<Ingredient> items);
}
