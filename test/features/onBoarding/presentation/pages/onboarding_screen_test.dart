import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/pages/onboarding_screen.dart';
import 'package:super_fitness_app/features/onBoarding/domain/usecase/set_onboarding_as_seen_usecase.dart';
import 'package:super_fitness_app/core/di/di.dart';

import '../widgets/onboarding_buttons_test.mocks.dart';

@GenerateMocks([SetOnboardingAsSeenUsecase])
void main() {
  late MockSetOnboardingAsSeenUsecase mockSetOnboardingAsSeenUsecase;

  setUp(() {
    mockSetOnboardingAsSeenUsecase = MockSetOnboardingAsSeenUsecase();
    getIt.registerSingleton<SetOnboardingAsSeenUsecase>(
      mockSetOnboardingAsSeenUsecase,
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('renders onboarding screen with images and skip button', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const OnboardingScreen(),
        routes: {
          '/login': (context) => const Scaffold(body: Text('Login Screen')),
        },
      ),
    );

    expect(find.byType(PageView), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
  });

  testWidgets('calls usecase when pressing Skip button', (tester) async {
    when(
      mockSetOnboardingAsSeenUsecase.invoke(),
    ).thenAnswer((_) async => Future.value());

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const OnboardingScreen(),
        routes: {
          '/login': (context) => const Scaffold(body: Text('Login Screen')),
        },
      ),
    );

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    verify(mockSetOnboardingAsSeenUsecase.invoke()).called(1);
    expect(find.text('Login Screen'), findsOneWidget);
  });

  testWidgets('shows next page when pressing Next button', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const OnboardingScreen(),
        routes: {
          '/login': (context) => const Scaffold(body: Text('Login Screen')),
        },
      ),
    );

    final nextButton = find.text('Next');
    expect(nextButton, findsOneWidget);

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    expect(find.byType(PageView), findsOneWidget);
  });
}
