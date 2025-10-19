import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

void main() {
  testWidgets("showLoading should display loading dialog", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
    );

    DialogueUtils.showLoading(
      context: tester.element(find.byType(SizedBox)),
      message: "Loading...",
    );

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading..."), findsOneWidget);
  });

  testWidgets("showAlertDialog should display error dialog", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [AppLocalizations.delegate],
        home: Scaffold(body: SizedBox.shrink()),
      ),
    );

    DialogueUtils.showAlertDialog(
      tester.element(find.byType(SizedBox)),
      "Something went wrong",
    );

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Something went wrong"), findsOneWidget);
    expect(find.text("Error"), findsOneWidget);
  });

  testWidgets("hideLoading should close dialog", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
    );

    DialogueUtils.showLoading(
      context: tester.element(find.byType(SizedBox)),
      message: "Loading...",
    );
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);

    DialogueUtils.hideLoading(tester.element(find.byType(SizedBox)));
    await tester.pump();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets("showMessage should show dialog with custom actions", (
    tester,
  ) async {
    bool pressed = false;

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
    );

    DialogueUtils.showMessage(
      context: tester.element(find.byType(SizedBox)),
      message: "Hello",
      title: "Title",
      posActionName: "OK",
      posAction: () {
        pressed = true;
      },
    );

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Hello"), findsOneWidget);
    expect(find.text("Title"), findsOneWidget);

    await tester.tap(find.text("OK"));
    await tester.pump();

    expect(pressed, isTrue);
  });
}
