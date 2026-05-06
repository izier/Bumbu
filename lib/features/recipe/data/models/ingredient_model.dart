import '../../domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  const IngredientModel({
    required super.id,
    required super.name,
    required super.displayName,
    required super.quantity,
    required super.unit,
    super.note,
  });

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      displayName: map['displayName'] ?? '',
      quantity: (map['quantity'] ?? 0).toDouble(),
      unit: map['unit'] ?? '',
      note: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'quantity': quantity,
      'unit': unit,
      'note': note,
    };
  }
}
