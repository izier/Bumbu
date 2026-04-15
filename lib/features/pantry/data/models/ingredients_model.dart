import '../../domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    required super.id,
    required super.name,
    required super.confidence,
    required super.lastUpdated,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'],
      name: json['name'],
      confidence: ConfidenceLevel.values.firstWhere(
            (e) => e.name == json['confidence'],
      ),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'confidence': confidence.name,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory IngredientModel.fromEntity(Ingredient ingredient) {
    return IngredientModel(
      id: ingredient.id,
      name: ingredient.name,
      confidence: ingredient.confidence,
      lastUpdated: ingredient.lastUpdated,
    );
  }

  Ingredient toEntity() {
    return Ingredient(
      id: id,
      name: name,
      confidence: confidence,
      lastUpdated: lastUpdated,
    );
  }
}
