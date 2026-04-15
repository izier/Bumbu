import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/ingredient.dart';
import '../../domain/usecases/get_pantry.dart';
import '../../domain/usecases/add_ingredient.dart';
import '../../domain/usecases/update_confidence.dart';
import '../../domain/usecases/remove_ingredient.dart';
import '../../domain/usecases/refresh_pantry.dart';
import '../../domain/usecases/generate_insight.dart';

import '../../data/datasources/pantry_local_datasource.dart';
import '../../data/repositories/pantry_repository_impl.dart';

/// --- Repository Provider ---
final pantryRepositoryProvider = Provider((ref) {
  return PantryRepositoryImpl(PantryLocalDataSource());
});

/// --- UseCases ---
final getPantryProvider = Provider(
      (ref) => GetPantry(ref.read(pantryRepositoryProvider)),
);

final addIngredientProvider = Provider(
      (ref) => AddIngredient(ref.read(pantryRepositoryProvider)),
);

final updateConfidenceProvider = Provider(
      (ref) => UpdateConfidence(ref.read(pantryRepositoryProvider)),
);

final removeIngredientProvider = Provider(
      (ref) => RemoveIngredient(ref.read(pantryRepositoryProvider)),
);

final refreshPantryProvider = Provider((ref) => RefreshPantry());

final generateInsightProvider = Provider((ref) => GenerateInsight());

/// --- StateNotifier ---
class PantryNotifier extends StateNotifier<List<Ingredient>> {
  final Ref ref;

  PantryNotifier(this.ref) : super([]);

  Future<void> load() async {
    final items = await ref.read(getPantryProvider).call();
    final refreshed = ref.read(refreshPantryProvider).call(items);

    state = refreshed;

    await ref.read(pantryRepositoryProvider).savePantry(refreshed);
  }

  Future<void> add(String name) async {
    state = await ref
        .read(addIngredientProvider)
        .call(state, name);
  }

  Future<void> update(String id, ConfidenceLevel level) async {
    state = await ref
        .read(updateConfidenceProvider)
        .call(state, id, level);
  }

  Future<void> remove(int index) async {
    state = await ref
        .read(removeIngredientProvider)
        .call(state, index);
  }
}

/// --- Main Provider ---
final pantryProvider =
StateNotifierProvider<PantryNotifier, List<Ingredient>>(
      (ref) => PantryNotifier(ref),
);

/// --- Derived Provider (Insight) ---
final pantryInsightProvider = Provider<String>((ref) {
  final items = ref.watch(pantryProvider);
  final generator = ref.watch(generateInsightProvider);

  return generator.call(items);
});

