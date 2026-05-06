import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipe {
  final RecipeRepository repository;

  GetRecipe(this.repository);

  Future<Recipe> call(String id) async {
    return repository.getRecipe(id);
  }
}
