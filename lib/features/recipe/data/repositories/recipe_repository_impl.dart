import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_remote_datasource.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remote;

  RecipeRepositoryImpl(this.remote);

  @override
  Future<String> createRecipe(Recipe recipe) async {
    final model = RecipeModel(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      ingredients: recipe.ingredients,
      steps: recipe.steps,
      authorId: recipe.authorId,
      createdAt: recipe.createdAt,
      servings: recipe.servings,
      sourceType: recipe.sourceType,
    );

    final id = await remote.createRecipe(model); // ✅ MUST assign
    return id; // ✅ MUST return
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    final model = RecipeModel(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      ingredients: recipe.ingredients,
      steps: recipe.steps,
      authorId: recipe.authorId,
      createdAt: recipe.createdAt,
      servings: recipe.servings,
      sourceType: recipe.sourceType,
    );

    await remote.updateRecipe(model);
  }

  @override
  Future<Recipe> getRecipe(String id) async {
    return await remote.getRecipe(id);
  }
}