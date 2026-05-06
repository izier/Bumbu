class Ingredient {
  final String id;
  final String name;
  final String displayName;
  final double quantity;
  final String unit;
  final String? note;

  const Ingredient({
    required this.id,
    required this.name,
    required this.displayName,
    required this.quantity,
    required this.unit,
    this.note,
  });
}
