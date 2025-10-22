import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/onBoarding/domain/usecase/set_onboarding_as_seen_usecase.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_buttons.dart';

import 'onboarding_buttons_test.mocks.dart';

@GenerateMocks([SetOnboardingAsSeenUsecase])
void main() {
  late PageController pageController;
  late MockSetOnboardingAsSeenUsecase mockUsecase;

  setUp(() async {
    pageController = PageController();
    mockUsecase = MockSetOnboardingAsSeenUsecase();
    await getIt.reset();
    getIt.registerLazySingleton<SetOnboardingAsSeenUsecase>(() => mockUsecase);
  });

  group('OnboardingButtons Widget Tests', () {
    testWidgets('renders Next button on first page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: OnboardingButtons(
              pageController: pageController,
              currentIndex: 0,
              onPageChange: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Next'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders Back and Next buttons on middle page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: OnboardingButtons(
              pageController: pageController,
              currentIndex: 1,
              onPageChange: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders Got it button on last page and triggers usecase', (
      WidgetTester tester,
    ) async {
      when(mockUsecase.invoke()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.login: (context) =>
                const Scaffold(body: Text('Login Screen')),
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: OnboardingButtons(
              pageController: pageController,
              currentIndex: 2,
              onPageChange: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Got it'), findsOneWidget);
      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();
      verify(mockUsecase.invoke()).called(1);
      expect(find.text('Login Screen'), findsOneWidget);
    });
  });
}
