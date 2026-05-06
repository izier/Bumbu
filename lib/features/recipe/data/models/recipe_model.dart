import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/entities/ingredient.dart';
import '../../domain/entities/step.dart';
import 'ingredient_model.dart';
import 'step_model.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.ingredients,
    required super.steps,
    required super.authorId,
    required super.createdAt,
    required super.servings,
    required super.sourceType,
  });

  factory RecipeModel.fromMap(String id, Map<String, dynamic> map) {
    return RecipeModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      ingredients: (map['ingredients'] as List<dynamic>? ?? [])
          .map((e) => IngredientModel.fromMap(e))
          .toList(),
      steps: (map['steps'] as List<dynamic>? ?? [])
          .map((e) => StepModel.fromMap(e))
          .toList(),
      authorId: map['authorId'] ?? '',
      createdAt: _dateTimeFromMap(map['createdAt']),
      servings: (map['servings'] as num?)?.toInt() ?? 1,
      sourceType: map['sourceType'] ?? 'manual',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'ingredients': ingredients.map(_ingredientToMap).toList(),
      'steps': steps.map(_stepToMap).toList(),
      'authorId': authorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'servings': servings,
      'sourceType': sourceType,
    };
  }

  Map<String, dynamic> _ingredientToMap(Ingredient ingredient) {
    if (ingredient is IngredientModel) {
      return ingredient.toMap();
    }

    return {
      'id': ingredient.id,
      'name': ingredient.name,
      'displayName': ingredient.displayName,
      'quantity': ingredient.quantity,
      'unit': ingredient.unit,
      'note': ingredient.note,
    };
  }

  Map<String, dynamic> _stepToMap(Step step) {
    if (step is StepModel) {
      return step.toMap();
    }

    return {
      'index': step.index,
      'instruction': step.instruction,
      'duration': step.duration,
    };
  }

  static DateTime _dateTimeFromMap(dynamic value) {
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }

    return DateTime.now();
  }
}
