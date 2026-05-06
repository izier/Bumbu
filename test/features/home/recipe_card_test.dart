import 'package:bumbu/features/home/presentation/widgets/recipe_card.dart';
import 'package:bumbu/features/recipe/domain/entities/ingredient.dart';
import 'package:bumbu/features/recipe/domain/entities/recipe.dart';
import 'package:bumbu/features/recipe/domain/entities/step.dart';
import 'package:bumbu/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recipeTotalDurationLabel sums every step duration', () {
    final recipe = Recipe(
      id: 'recipe-1',
      title: 'Recipe',
      description: '',
      ingredients: [
        Ingredient(
          id: 'i1',
          name: 'Salt',
          displayName: '1 tsp Salt',
          quantity: 1,
          unit: 'tsp',
        ),
      ],
      steps: [
        Step(index: 0, instruction: 'Prep', duration: 120),
        Step(index: 1, instruction: 'Cook', duration: 240),
      ],
      authorId: 'u1',
      createdAt: nullDate,
      servings: 1,
      sourceType: 'manual',
    );

    expect(recipeTotalDurationLabel(AppLocalizationsEn(), recipe), '6 min');
  });

  test('friendlyDurationLabel uses singular and compound labels', () {
    final t = AppLocalizationsEn();

    expect(friendlyDurationLabel(t, const Duration(seconds: 1)), '1 sec');
    expect(friendlyDurationLabel(t, const Duration(minutes: 1)), '1 min');
    expect(
      friendlyDurationLabel(t, const Duration(hours: 2, minutes: 5)),
      '2 hr 5 min',
    );
  });
}

final nullDate = DateTime.fromMillisecondsSinceEpoch(0);
