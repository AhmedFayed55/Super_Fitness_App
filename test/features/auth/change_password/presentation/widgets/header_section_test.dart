import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/header_section.dart';

void main() {
  testWidgets("Test Header_Section en", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale("en"),
        home: HeaderSection(),
      ),
    );

    expect(find.byType(Column), findsOne);
    expect(find.byType(Center), findsOne);
    expect(find.byType(Padding), findsOne);
    expect(find.byType(RichText), findsOne);
    expect(find.byType((Image)), findsOne);
  });

  testWidgets("Test Header_Section ar", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale("ar"),
        home: HeaderSection(),
      ),
    );

    expect(find.byType(Column), findsOne);
    expect(find.byType(Center), findsOne);
    expect(find.byType(Padding), findsOne);
    expect(find.byType(RichText), findsOne);
    expect(find.byType((Image)), findsOne);
  });
}
