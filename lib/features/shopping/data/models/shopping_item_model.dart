import '../../domain/entities/shopping_item.dart';

class ShoppingItemModel extends ShoppingItem {
  ShoppingItemModel({
    required super.id,
    required super.name,
    required super.quantity,
    super.unit,
    required super.isChecked,
    required super.category,
    super.recipeName,
  });

  factory ShoppingItemModel.fromJson(Map<String, dynamic> json) {
    return ShoppingItemModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
      isChecked: json['isChecked'],
      category: json['category'],
      recipeName: json['recipeName']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'isChecked': isChecked,
      'category': category,
      'recipeName': recipeName
    };
  }

  factory ShoppingItemModel.fromEntity(ShoppingItem item) {
    return ShoppingItemModel(
      id: item.id,
      name: item.name,
      quantity: item.quantity,
      unit: item.unit,
      isChecked: item.isChecked,
      category: item.category,
      recipeName: item.recipeName
    );
  }

  @override
  ShoppingItemModel copyWith({
    String? id,
    String? name,
    String? quantity,
    String? unit,
    bool? isChecked,
    String? category,
    String? source,
    String? recipeName,
  }) {
    return ShoppingItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      isChecked: isChecked ?? this.isChecked,
      category: category ?? this.category,
      recipeName: recipeName ?? this.recipeName,
    );
  }

  ShoppingItem toEntity() {
    return ShoppingItem(
      id: id,
      name: name,
      quantity: quantity,
      unit: unit,
      isChecked: isChecked,
      category: category,
      recipeName: recipeName
    );
  }
}
