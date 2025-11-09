import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_page_view.dart';

void main() {
  group('OnboardingPageView Widget Tests', () {
    late PageController controller;
    final images = [
      AppAssets.onboarding1,
      AppAssets.onboarding2,
      AppAssets.onboarding3,
    ];

    setUp(() {
      controller = PageController();
    });

    testWidgets('renders all images correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingPageView(controller: controller, images: images),
          ),
        ),
      );

      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('PageView uses NeverScrollableScrollPhysics', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingPageView(controller: controller, images: images),
          ),
        ),
      );

      final pageView = tester.widget<PageView>(find.byType(PageView));
      expect(pageView.physics, isA<NeverScrollableScrollPhysics>());
    });

    testWidgets('displays correct image for current page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingPageView(controller: controller, images: images),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(FittedBox), findsOneWidget);
    });
  });
}
