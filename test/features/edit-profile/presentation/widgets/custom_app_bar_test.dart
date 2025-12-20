import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

void main() {
  testWidgets('customAppBar displays title and triggers back navigation', (
    tester,
  ) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Navigator(
          onGenerateRoute: (_) {
            return MaterialPageRoute(builder: (context) => const Scaffold());
          },
        ),
      ),
    );

    expect(find.text("Edit Profile"), findsOneWidget);

    final backButton = find.byType(IconButton);
    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Assert
    expect(find.text("Edit Profile"), findsNothing);
  });
}
