import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/feature_placeholder_page.dart';

class CookingPage extends StatelessWidget {
  const CookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return FeaturePlaceholderPage(title: t.cookingMode);
  }
}
