import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/level_widget.dart';

void main() {
  group('LevelWidget', () {
    testWidgets(
      'should display the level text and apply selected style when isSelected = true',
      (WidgetTester tester) async {
        // arrange
        const widget = MaterialApp(
          home: Scaffold(
            body: LevelWidget(isSelected: true, level: 'Beginner'),
          ),
        );

        // act
        await tester.pumpWidget(widget);

        // assert
        final textFinder = find.text('Beginner');
        expect(textFinder, findsOneWidget);

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, isNot(equals(Colors.transparent)));

        final text = tester.widget<Text>(textFinder);
        expect(text.style?.fontWeight, AppFontWeight.extraBold);
      },
    );

    testWidgets(
      'should display transparent background when isSelected = false',
      (WidgetTester tester) async {
        // arrange
        const widget = MaterialApp(
          home: Scaffold(
            body: LevelWidget(isSelected: false, level: 'Advanced'),
          ),
        );

        // act
        await tester.pumpWidget(widget);

        // assert
        expect(find.text('Advanced'), findsOneWidget);

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Colors.transparent));
      },
    );
  });
}
