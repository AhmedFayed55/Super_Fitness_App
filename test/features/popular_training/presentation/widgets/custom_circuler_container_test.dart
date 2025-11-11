import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/custom_circuler_container.dart';

void main() {
  testWidgets('CustomCirculerContainer builds correctly with child', (
    tester,
  ) async {
    // Arrange
    const testKey = Key('child_text');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomCirculerContainer(child: Text('Hello', key: testKey)),
        ),
      ),
    );

    // Act
    final containerFinder = find.byType(Container);
    final textFinder = find.byKey(testKey);

    // Assert
    expect(containerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);

    final containerWidget = tester.widget<Container>(containerFinder.first);

    final boxDecoration = containerWidget.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.cmykColor);

    expect(boxDecoration.borderRadius, BorderRadius.circular(20));
  });
}
