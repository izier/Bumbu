import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<String> createRecipe(Recipe recipe); // ✅ String
  Future<void> updateRecipe(Recipe recipe);
  Future<Recipe> getRecipe(String id);
}
