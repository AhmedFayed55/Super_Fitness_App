import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_bottom_section.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_buttons.dart';

void main() {
  group('OnboardingBottomSection Widget Tests', () {
    late PageController pageController;
    int currentIndex = 0;

    setUp(() {
      pageController = PageController();
    });

    testWidgets('should render title, description, and buttons correctly', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: OnboardingBottomSection(
              pageController: pageController,
              currentIndex: currentIndex,
              onPageChange: (_) {},
            ),
          ),
        ),
      );

      expect(
        find.text('the price of excellence\n is discipline'),
        findsOneWidget,
      );
      expect(find.textContaining('Lorem ipsum dolor'), findsOneWidget);
      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
      expect(find.byType(OnboardingButtons), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('should update title when currentIndex changes', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;

      late void Function(void Function()) setStateCallback;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                setStateCallback = setState;
                return OnboardingBottomSection(
                  pageController: pageController,
                  currentIndex: currentIndex,
                  onPageChange: (index) => setState(() => currentIndex = index),
                );
              },
            ),
          ),
        ),
      );

      expect(
        find.text('the price of excellence\n is discipline'),
        findsOneWidget,
      );

      setStateCallback(() => currentIndex = 2);
      await tester.pump();

      expect(
        find.text('the price of excellence\n is discipline'),
        findsNothing,
      );
      expect(find.text('NO MORE EXCUSES \n Do It Now'), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });
  });
}
