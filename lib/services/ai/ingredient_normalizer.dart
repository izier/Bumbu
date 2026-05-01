class IngredientNormalizer {
  Map<String, dynamic> normalize(Map<String, dynamic> ingredient) {
    return {
      'name': ingredient['name'].toString().toLowerCase(),
      'quantity': ingredient['quantity'],
      'unit': ingredient['unit'],
    };
  }
}
