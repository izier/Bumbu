import 'ingredient.dart';
import 'step.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<Step> steps;
  final String authorId;
  final DateTime createdAt;
  final int servings;
  final String sourceType; // manual | imported

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.authorId,
    required this.createdAt,
    required this.servings,
    required this.sourceType,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    List<Ingredient>? ingredients,
    List<Step>? steps,
    String? authorId,
    DateTime? createdAt,
    int? servings,
    String? sourceType,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      servings: servings ?? this.servings,
      sourceType: sourceType ?? this.sourceType,
    );
  }
}
