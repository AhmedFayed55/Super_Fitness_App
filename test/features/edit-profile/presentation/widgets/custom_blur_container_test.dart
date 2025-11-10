import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/custom_blur_container.dart';

void main() {
  testWidgets(
    'CustomBlurContainerFields renders child and applies blur effect',
    (tester) async {
      // Arrange
      const testKey = Key('test_child');

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CustomBlurContainerFields(
              child: Container(
                key: testKey,
                color: Colors.red,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(testKey), findsOneWidget);

      expect(find.byType(BackdropFilter), findsOneWidget);

      // Assert
      final blurWidget = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      final ImageFilter filter = blurWidget.filter;
      expect(filter, isA<ImageFilter>());
    },
  );
}
