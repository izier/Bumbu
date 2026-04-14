// usecases/get_pantry.dart

import '../entities/ingredient.dart';
import '../repositories/pantry_repository.dart';

class GetPantry {
  final PantryRepository repository;

  GetPantry(this.repository);

  Future<List<Ingredient>> call() async {
    return await repository.getPantry();
  }
}
