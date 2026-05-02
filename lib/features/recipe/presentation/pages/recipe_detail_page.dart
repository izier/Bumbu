import 'package:flutter/material.dart';

import '../../../../shared/widgets/feature_placeholder_page.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return FeaturePlaceholderPage(label: 'Recipe: $id');
  }
}
