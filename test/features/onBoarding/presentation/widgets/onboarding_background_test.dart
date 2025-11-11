import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_background.dart';
import 'package:super_fitness_app/core/utils/assets.dart';

void main() {
  testWidgets(
    'renders onboarding background with decoration image and blur overlay',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: OnboardingBackground())),
      );

      final containerWithDecoration = find.byWidgetPredicate((widget) {
        if (widget is Container && widget.decoration is BoxDecoration) {
          final decoration = widget.decoration as BoxDecoration;
          return decoration.image?.image is AssetImage &&
              (decoration.image!.image as AssetImage).assetName ==
                  AppAssets.onboardingMain;
        }
        return false;
      });

      expect(containerWithDecoration, findsOneWidget);

      expect(find.byType(BackdropFilter), findsOneWidget);
    },
  );
}
