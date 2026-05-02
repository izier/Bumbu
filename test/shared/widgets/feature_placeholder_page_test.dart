import 'package:bumbu/shared/widgets/feature_placeholder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the placeholder label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: FeaturePlaceholderPage(label: 'Feed')),
    );

    expect(find.text('Feed'), findsOneWidget);
  });
}
