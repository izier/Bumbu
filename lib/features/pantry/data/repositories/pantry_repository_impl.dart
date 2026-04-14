// features/pantry/data/repositories/pantry_repository_impl.dart

import '../../domain/entities/ingredient.dart';
import '../../domain/repositories/pantry_repository.dart';
import '../datasources/pantry_local_datasource.dart';
import '../models/ingredients_model.dart';

class PantryRepositoryImpl implements PantryRepository {
  final PantryLocalDataSource localDataSource;

  PantryRepositoryImpl(this.localDataSource);

  @override
  Future<List<Ingredient>> getPantry() async {
    final models = await localDataSource.loadPantry();

    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> savePantry(List<Ingredient> items) async {
    final models =
    items.map((e) => IngredientModel.fromEntity(e)).toList();

    await localDataSource.savePantry(models);
  }
}
