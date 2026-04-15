import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/shopping_item_model.dart';

class ShoppingLocalDatasource {
  static const String key = 'shopping_items';

  Future<List<ShoppingItemModel>> loadShoppingList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);

    return decoded
        .map((e) => ShoppingItemModel.fromJson(e))
        .toList();
  }

  Future<void> saveShoppingList(List<ShoppingItemModel> items) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = items.map((e) => e.toJson()).toList();

    await prefs.setString(key, jsonEncode(jsonList));
  }
}
