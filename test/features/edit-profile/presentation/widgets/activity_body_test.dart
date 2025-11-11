import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/activity_body.dart'; // أو الباث الصحيح عندك

void main() {
  group("ActivitySelector Widget Test", () {
    testWidgets('should render activities list and handle selection & next', (
      tester,
    ) async {
      // Arrange
      final activities = ["Beginner", "Intermediate", "Advanced"];
      String selected = "Intermediate";
      String? receivedSelected;
      bool nextPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ActivitySelector(
              activities: activities,
              selectedActivity: selected,
              onSelect: (val) => receivedSelected = val,
              onNext: () => nextPressed = true,
            ),
          ),
        ),
      );

      // Assert UI elements appear
      expect(find.text("Beginner"), findsOneWidget);
      expect(find.text("Intermediate"), findsOneWidget);
      expect(find.text("Advanced"), findsOneWidget);

      // Tap on "Advanced" Radio
      await tester.tap(
        find.byWidgetPredicate((widget) {
          return widget is Radio<String> && widget.value == "Advanced";
        }),
      );
      await tester.pump();

      expect(receivedSelected, "Advanced");

      // Tap "Done" button
      await tester.tap(find.text("Done")); // لو اسم الزر مختلف غيره
      await tester.pump();

      expect(nextPressed, true);
    });
  });
}
