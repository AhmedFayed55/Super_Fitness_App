import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/goal_selector.dart';

import 'goal_selector_test.mocks.dart';

abstract class OnNextCallback {
  void call();
}

abstract class OnSelectCallback {
  void call(String value);
}

@GenerateMocks([OnNextCallback, OnSelectCallback])
void main() {
  late MockOnNextCallback mockOnNext;
  late MockOnSelectCallback mockOnSelect;

  final goals = ["Gain weight", "Lose weight", "Get fitter"];

  setUp(() {
    mockOnNext = MockOnNextCallback();
    mockOnSelect = MockOnSelectCallback();
  });

  Widget buildWidget(String selectedGoal) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GoalSelector(
          goals: goals,
          selectedGoal: selectedGoal,
          onSelect: mockOnSelect.call,
          onNext: mockOnNext.call,
        ),
      ),
    );
  }

  testWidgets('displays all goal options', (tester) async {
    await tester.pumpWidget(buildWidget(goals[0]));
    await tester.pumpAndSettle();

    for (var g in goals) {
      expect(find.text(g), findsOneWidget);
    }
  });

  testWidgets('calls onNext when Done button is pressed', (tester) async {
    await tester.pumpWidget(buildWidget(goals[0]));
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('Done'));
    await tester.pump();

    verify(mockOnNext.call()).called(1);
  });
}
