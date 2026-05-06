import '../../../../../l10n/app_localizations.dart';
import '../../domain/entities/step.dart';

String unitLabel(AppLocalizations t, String unit) {
  switch (unit) {
    case 'g':
      return t.unitGram;
    case 'kg':
      return t.unitKilogram;
    case 'ml':
      return t.unitMilliliter;
    case 'l':
      return t.unitLiter;
    case 'pcs':
      return t.unitPiece;
    case 'tbsp':
      return t.unitTablespoon;
    case 'tsp':
      return t.unitTeaspoon;
    case 'cup':
      return t.unitCup;
    default:
      return unit;
  }
}

List<Step> normalizedSteps(List<Step> source) {
  return [
    for (var i = 0; i < source.length; i++)
      Step(
        index: i,
        instruction: source[i].instruction,
        duration: source[i].duration,
      ),
  ];
}