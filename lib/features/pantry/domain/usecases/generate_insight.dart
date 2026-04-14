// usecases/generate_insight.dart

import '../entities/ingredient.dart';
import '../services/pantry_engine.dart';

class GenerateInsight {
  String call(List<Ingredient> items) {
    return PantryEngine.generateInsight(items);
  }
}
