import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';
import 'package:super_fitness_app/features/workouts/presentation/widgets/muscle_group_tab.dart';

void main() {
  group('MuscleGroupTab Widget', () {
    testWidgets('renders label text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MuscleGroupTab(
              label: 'Chest',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Chest'), findsOneWidget);
    });

    testWidgets('applies primary color when selected', (tester) async {
      const testColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: testColor),
          ),
          home: Scaffold(
            body: MuscleGroupTab(label: 'Back', isSelected: true, onTap: () {}),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MuscleGroupTab),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, testColor);
      expect(decoration.border!.top.color, testColor);
    });

    testWidgets('has transparent color when not selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: Colors.blue),
          ),
          home: Scaffold(
            body: MuscleGroupTab(
              label: 'Legs',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MuscleGroupTab),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.transparent);
      expect(decoration.border!.top.color, Colors.transparent);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MuscleGroupTab(
              label: 'Arms',
              isSelected: false,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MuscleGroupTab));
      await tester.pump(const Duration(milliseconds: 100));

      expect(tapped, isTrue);
    });

    testWidgets('uses extraBold font weight for label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MuscleGroupTab(
              label: 'Shoulders',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Shoulders'));
      expect(text.style?.fontWeight, AppFontWeight.extraBold);
    });
  });
}
