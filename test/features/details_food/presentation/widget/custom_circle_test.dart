import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_circle.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CustomCircle Widget Test', () {
    testWidgets('renders correctly with name and countyItem', (tester) async {
      // Arrange
      const testName = 'Steps';
      const testCount = '1200';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCircle(name: testName, countyItem: testCount),
          ),
        ),
      );

      // Assert
      expect(find.byType(CustomCircle), findsOneWidget);
      expect(find.text(testName), findsOneWidget);
      expect(find.text(testCount), findsOneWidget);
    });

    testWidgets('contains BackdropFilter with correct blur values', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCircle(name: 'Calories', countyItem: '250'),
          ),
        ),
      );

      final blurWidget = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      final filter = blurWidget.filter;

      expect(filter, isA<ImageFilter>());
      expect(AppConstants.sigmaX, greaterThanOrEqualTo(0));
      expect(AppConstants.sigmaY, greaterThanOrEqualTo(0));
    });

    testWidgets('has a container with proper decoration and radius', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCircle(name: 'Protein', countyItem: '30g'),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CustomCircle),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;

      expect(decoration.borderRadius, isNotNull);
      expect(decoration.border, isA<Border>());
      expect(decoration.color, isA<Color>());
    });

    testWidgets('renders text with correct styles', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: CustomCircle(name: 'Fat', countyItem: '10g'),
          ),
        ),
      );

      final textWidgets = tester.widgetList<Text>(find.byType(Text)).toList();

      expect(textWidgets[0].data, '10g');
      expect(textWidgets[1].data, 'Fat');
    });
  });
}
