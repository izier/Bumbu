// usecases/refresh_pantry.dart

import '../entities/ingredient.dart';
import '../services/pantry_engine.dart';

class RefreshPantry {
  List<Ingredient> call(List<Ingredient> items) {
    return PantryEngine.refreshPantry(items);
  }
}
