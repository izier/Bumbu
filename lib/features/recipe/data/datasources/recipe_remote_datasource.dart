import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<String> createRecipe(RecipeModel recipe);
  Future<void> updateRecipe(RecipeModel recipe);
  Future<RecipeModel> getRecipe(String id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final FirebaseFirestore firestore;

  RecipeRemoteDataSourceImpl(this.firestore);

  @override
  Future<String> createRecipe(RecipeModel recipe) async {
    final doc = firestore.collection('recipes').doc();

    final data = recipe.toMap();
    data['id'] = doc.id;

    await doc.set(data);

    return doc.id; // ✅ REQUIRED
  }

  @override
  Future<void> updateRecipe(RecipeModel recipe) async {
    await firestore
        .collection('recipes')
        .doc(recipe.id)
        .update(recipe.toMap());
  }

  @override
  Future<RecipeModel> getRecipe(String id) async {
    final doc = await firestore.collection('recipes').doc(id).get();

    if (!doc.exists) {
      throw Exception('Recipe not found');
    }

    return RecipeModel.fromMap(doc.id, doc.data()!);
  }
}
