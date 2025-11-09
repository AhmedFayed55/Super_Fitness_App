import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/blur_container.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrapWithMaterialApp(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  group('BlurContainer Widget Tests', () {
    testWidgets('renders all children inside BlurContainer', (tester) async {
      final children = [const Text('Child 1'), const Icon(Icons.ac_unit)];

      await tester.pumpWidget(
        wrapWithMaterialApp(BlurContainer(children: children)),
      );

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.byIcon(Icons.ac_unit), findsOneWidget);
    });

    testWidgets('applies default background color and blur', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(const BlurContainer(children: [Text('Test')])),
      );

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder.first);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, AppColors.glassBackground);
    });

    testWidgets('uses custom background color when provided', (tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        wrapWithMaterialApp(
          const BlurContainer(
            backgroundColor: customColor,
            children: [Text('Colored')],
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder.first);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, customColor);
    });

    testWidgets('applies custom padding when provided', (tester) async {
      const customPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        wrapWithMaterialApp(
          const BlurContainer(
            padding: customPadding,
            children: [Text('Padding')],
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder.first);

      expect(container.padding, customPadding);
    });

    testWidgets('applies correct border radius when provided', (tester) async {
      const customRadius = 16.0;

      await tester.pumpWidget(
        wrapWithMaterialApp(
          const BlurContainer(
            borderRadius: customRadius,
            children: [Text('Radius')],
          ),
        ),
      );

      final clipFinder = find.byType(ClipRRect);
      final clip = tester.widget<ClipRRect>(clipFinder);

      expect(clip.borderRadius, BorderRadius.circular(customRadius));
    });

    testWidgets('contains BackdropFilter for blur effect', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(const BlurContainer(children: [Text('Blur')])),
      );

      final filterFinder = find.byType(BackdropFilter);
      expect(filterFinder, findsOneWidget);

      final blurWidget = tester.widget<BackdropFilter>(filterFinder);
      final blur = blurWidget.filter;

      expect(blur, isA<ImageFilter>());
    });
  });
}
