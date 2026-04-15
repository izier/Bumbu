import '../entities/ingredient.dart';

abstract class PantryRepository {
  Future<List<Ingredient>> getPantry();
  Future<void> savePantry(List<Ingredient> items);
}
