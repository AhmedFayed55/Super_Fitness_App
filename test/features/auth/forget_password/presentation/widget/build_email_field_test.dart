import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/build_email_field.dart';

void main() {
  group('BuildEmailField Widget Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget wrapWithMaterialApp(Widget child) {
      return MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) =>
                BuildEmailField(controller: controller, context: context),
          ),
        ),
      );
    }

    testWidgets('renders email field with correct properties', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('displays correct hint text from localization', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.hintText, 'Email');
    });

    testWidgets('has correct keyboard type and input action', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.emailAddress);
      expect(textField.textInputAction, TextInputAction.next);
    });

    testWidgets('has correct autofill hints', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofillHints, const [AutofillHints.email]);
    });

    testWidgets('has correct floating label behavior', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(
        textField.decoration?.floatingLabelBehavior,
        FloatingLabelBehavior.always,
      );
    });

    testWidgets('has correct max lines', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, 1);
    });

    testWidgets('has correct error max lines', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.errorMaxLines, 2);
    });

    testWidgets('can input text and updates controller', (tester) async {
      const testEmail = 'test@example.com';

      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));
      await tester.enterText(find.byType(TextFormField), testEmail);

      expect(controller.text, testEmail);
    });

    testWidgets('validates email correctly when empty', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final formFieldState = tester.state<FormFieldState<String>>(
        find.byType(TextFormField),
      );
      final validationResult = formFieldState.validate();

      expect(validationResult, false);
      expect(formFieldState.errorText, 'Email is required!');
    });

    testWidgets('validates email correctly when invalid format', (
      tester,
    ) async {
      controller.text = 'invalid-email';

      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final formFieldState = tester.state<FormFieldState<String>>(
        find.byType(TextFormField),
      );
      final validationResult = formFieldState.validate();

      expect(validationResult, false);
      expect(formFieldState.errorText, 'This email is not valid');
    });

    testWidgets('validates email correctly when valid format', (tester) async {
      controller.text = 'test@example.com';

      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final formFieldState = tester.state<FormFieldState<String>>(
        find.byType(TextFormField),
      );
      final validationResult = formFieldState.validate();

      expect(validationResult, true);
      expect(formFieldState.errorText, isNull);
    });

    testWidgets('applies correct text style from theme', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.style, isNotNull);
    });

    testWidgets('applies correct hint style from theme', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.hintStyle, isNotNull);
    });

    testWidgets('has correct content padding', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const SizedBox.shrink()));

      final textField = tester.widget<TextField>(find.byType(TextField));
      final contentPadding =
          textField.decoration?.contentPadding as EdgeInsets?;
      expect(contentPadding, isNotNull);
      expect(contentPadding?.vertical, greaterThan(0));
      expect(contentPadding?.horizontal, greaterThan(0));
    });
  });
}
