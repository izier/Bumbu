enum ConfidenceLevel { high, medium, low }

class Ingredient {
  final String id;
  final String name;
  final ConfidenceLevel confidence;
  final DateTime lastUpdated;

  const Ingredient({
    required this.id,
    required this.name,
    required this.confidence,
    required this.lastUpdated,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    ConfidenceLevel? confidence,
    DateTime? lastUpdated,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      confidence: confidence ?? this.confidence,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
