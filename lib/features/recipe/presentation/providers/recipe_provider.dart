import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/usecases/create_recipe.dart';
import '../../domain/usecases/get_recipe.dart';
import '../../domain/usecases/update_recipe.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../data/datasources/recipe_remote_datasource.dart';
import '../../data/models/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final recipeRepositoryProvider = Provider((ref) {
  return RecipeRepositoryImpl(
    RecipeRemoteDataSourceImpl(FirebaseFirestore.instance),
  );
});

final createRecipeProvider = Provider((ref) {
  return CreateRecipe(ref.read(recipeRepositoryProvider));
});

final updateRecipeProvider = Provider((ref) {
  return UpdateRecipe(ref.read(recipeRepositoryProvider));
});

final getRecipeProvider = Provider((ref) {
  return GetRecipe(ref.read(recipeRepositoryProvider));
});

final recipeControllerProvider =
StateNotifierProvider<RecipeController, AsyncValue<Recipe?>>((ref) {
  return RecipeController(
    ref.read(createRecipeProvider),
    ref.read(updateRecipeProvider),
    ref.read(getRecipeProvider),
  );
});

class RecipeController extends StateNotifier<AsyncValue<Recipe?>> {
  final CreateRecipe createRecipe;
  final UpdateRecipe updateRecipe;
  final GetRecipe getRecipe;

  RecipeController(this.createRecipe, this.updateRecipe, this.getRecipe)
      : super(const AsyncData(null));

  Future<void> load(String id) async {
    state = const AsyncLoading();
    try {
      final recipe = await getRecipe(id);
      state = AsyncData(recipe);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<String?> create(Recipe recipe) async {
    state = const AsyncLoading();
    try {
      final id = await createRecipe(recipe);
      final newRecipe = recipe.copyWith(id: id);

      state = AsyncData(newRecipe);
      return id; // ✅ RETURN ID
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<void> update(Recipe recipe) async {
    state = const AsyncLoading();
    try {
      await updateRecipe(recipe);
      state = AsyncData(recipe);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final userRecipesProvider = StreamProvider.family<List<Recipe>, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection('recipes')
      .where('authorId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .limit(50)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => RecipeModel.fromMap(doc.id, doc.data()))
        .toList();
  });
});
