class ShoppingItem {
  final String id;
  final String name;
  final String quantity;
  final String? unit;
  final bool isChecked;
  final String category;
  final String? recipeName;

  const ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    this.unit,
    required this.isChecked,
    required this.category,
    this.recipeName,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    String? quantity,
    String? unit,
    bool? isChecked,
    String? category,
    String? source,
    String? recipeName,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      isChecked: isChecked ?? this.isChecked,
      category: category ?? this.category,
      recipeName: recipeName ?? this.recipeName,
    );
  }
}
