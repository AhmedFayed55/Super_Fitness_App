import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/register_actions.dart';

void main() {
  group('RegisterActions Widget Tests', () {
    testWidgets('renders all main elements correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          home: Scaffold(body: RegisterActions(onTapRegister: (){})),
        ),
      );

      expect(find.byType(RegisterActions), findsOneWidget);

      expect(find.byType(CustomElevatedButton), findsOneWidget);

      expect(find.byKey(const Key(AppKeys.alreadyHaveAccount)), findsOneWidget);
      expect(find.byKey(const Key(AppKeys.loginTextButton)), findsOneWidget);

      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('TextButton (Login) renders with underline decoration', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: RegisterActions(onTapRegister: (){})),
        ),
      );

      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      final textWidget = textButton.child as Text;

      expect(textWidget.style?.decoration, TextDecoration.underline);
    });

    testWidgets('CustomElevatedButton displays correct text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
         MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: RegisterActions(onTapRegister: (){})),
        ),
      );

      expect(find.byKey(const Key(AppKeys.registerAction)), findsOneWidget);
    });
  });
}
