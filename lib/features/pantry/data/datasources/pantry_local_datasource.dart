// features/pantry/data/datasources/pantry_local_datasource.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ingredients_model.dart';

class PantryLocalDataSource {
  static const String key = 'pantry_items';

  Future<List<IngredientModel>> loadPantry() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);

    return decoded
        .map((e) => IngredientModel.fromJson(e))
        .toList();
  }

  Future<void> savePantry(List<IngredientModel> items) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = items.map((e) => e.toJson()).toList();

    await prefs.setString(key, jsonEncode(jsonList));
  }
}
