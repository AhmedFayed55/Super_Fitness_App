import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/blur_container.dart';

void main() {
  testWidgets('renders CustomBlurContainer with child and correct decoration', (
    WidgetTester tester,
  ) async {
    // Arrange
    const testKey = Key('child-widget');
    const child = Text('Hello', key: testKey);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CustomBlurContainer(child: child)),
      ),
    );

    // Assert
    expect(find.byKey(testKey), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);

    final container = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(CustomBlurContainer),
            matching: find.byType(Container),
          )
          .first,
    );

    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, AppColors.cmykColor.withValues(alpha: 0.9));
    expect(decoration.borderRadius, isNotNull);
  });
}
