import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_blur_container.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CustomBlurContainer Widget Test', () {
    testWidgets('renders correctly with child', (tester) async {
      const childKey = Key('blur_child');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomBlurContainer(
              height: 200,
              child: Container(key: childKey, color: Colors.red),
            ),
          ),
        ),
      );

      expect(find.byType(CustomBlurContainer), findsOneWidget);
      expect(find.byKey(childKey), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('applies correct blur filter values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomBlurContainer(height: 100, child: SizedBox()),
          ),
        ),
      );

      final blurFilterWidget = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );

      final imageFilter = blurFilterWidget.filter;

      expect(imageFilter, isA<ImageFilter>());

      expect(AppConstants.sigmaX, isNonNegative);
      expect(AppConstants.sigmaY, isNonNegative);
    });

    testWidgets('applies top radius correctly when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomBlurContainer(
              height: 150,
              radiusValue: 15,
              child: SizedBox(),
            ),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      final borderRadius = clipRRect.borderRadius as BorderRadius;

      expect(borderRadius.topLeft.x, greaterThan(0));
    });
  });
}
