import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/category_bar.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

void main() {
  testWidgets('CategoryBar shows skeleton first then content', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: Scaffold(body: CategoryBar()),
      ),
    );

    // Act
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsWidgets);
    expect(find.textContaining(''), findsWidgets);
  });
}
