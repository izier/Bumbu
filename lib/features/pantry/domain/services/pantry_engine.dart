import '../../../../core/constants/app_constants.dart';
import '../entities/ingredient.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/services/id_generator.dart';

class PantryEngine {
  static Ingredient createIngredient(String name) {
    return Ingredient(
      id: IdGenerator.generate(),
      name: StringUtils.normalize(name),
      confidence: ConfidenceLevel.high,
      lastUpdated: DateTime.now(),
    );
  }

  static Ingredient updateConfidence(
      Ingredient ingredient, ConfidenceLevel level) {
    return ingredient.copyWith(
      confidence: level,
      lastUpdated: DateTime.now(),
    );
  }

  static Ingredient decayConfidence(Ingredient ingredient) {
    final daysPassed = DateUtilsHelper.daysBetween(
      ingredient.lastUpdated,
      DateTime.now(),
    );

    if (daysPassed > AppConstants.mediumToLowDays) {
      return ingredient.copyWith(confidence: ConfidenceLevel.low);
    } else if (daysPassed > AppConstants.highToMediumDays) {
      return ingredient.copyWith(confidence: ConfidenceLevel.medium);
    }
    return ingredient;
  }

  static List<Ingredient> refreshPantry(List<Ingredient> items) {
    return items.map(decayConfidence).toList();
  }

  static String generateInsight(List<Ingredient> items) {
    if (items.isEmpty) {
      return "Start adding ingredients 👀";
    }

    final high =
        items.where((e) => e.confidence == ConfidenceLevel.high).length;
    final low =
        items.where((e) => e.confidence == ConfidenceLevel.low).length;

    if (high > items.length * 0.6) {
      return "You're ready to cook";
    } else if (low > items.length * 0.4) {
      return "You might need groceries soon";
    } else {
      return "You have a few ingredients to work with";
    }
  }
}
