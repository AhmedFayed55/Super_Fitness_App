import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/app_sections/app_sections.dart';
import 'package:super_fitness_app/features/chat_bot/presentation/page/chat_bot_page.dart';
import 'package:super_fitness_app/features/explore/presentation/page/explore_page.dart';
import 'package:super_fitness_app/features/profile/presentation/page/profile_page.dart';
import 'package:super_fitness_app/features/workout/presentation/page/workout_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSections widget tests', () {
    testWidgets('renders AppSections and shows ExplorePage initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AppSections(),
        ),
      );

      expect(find.byType(ExplorePage), findsOneWidget);

      expect(find.byType(ChatBotPage), findsNothing);
      expect(find.byType(WorkoutPage), findsNothing);
      expect(find.byType(ProfilePage), findsNothing);
    });

    testWidgets('switches pages when navigation items are tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AppSections(),
        ),
      );

      expect(find.text('explore'), findsNothing);
      expect(find.byType(SvgPicture), findsNWidgets(4));

      await tester.tap(find.byType(GestureDetector).at(1));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      expect(find.byType(ChatBotPage), findsOneWidget);

      await tester.tap(find.byType(GestureDetector).at(2));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      expect(find.byType(WorkoutPage), findsOneWidget);

      await tester.tap(find.byType(GestureDetector).at(3));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      expect(find.byType(ProfilePage), findsOneWidget);

      await tester.tap(find.byType(GestureDetector).at(0));
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      expect(find.byType(ExplorePage), findsOneWidget);
    });
  });
}
