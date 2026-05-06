import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class UpdateRecipe {
  final RecipeRepository repository;

  UpdateRecipe(this.repository);

  Future<void> call(Recipe recipe) async {
    return repository.updateRecipe(recipe);
  }
}
