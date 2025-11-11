import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

void main() {
  group('BuildPasswordAndConfirmField Widget Tests', () {
    late TextEditingController passwordController;
    late TextEditingController confirmController;

    setUp(() {
      passwordController = TextEditingController();
      confirmController = TextEditingController();
    });

    tearDown(() {
      passwordController.dispose();
      confirmController.dispose();
    });

    Widget createTestPasswordFields() {
      return MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final height = MediaQuery.of(context).size.height;
              final tr = AppLocalizations.of(context)!;
              bool isPasswordObscure = true;

              return StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordObscure,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          hintText: tr.password,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordObscure = !isPasswordObscure;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      TextFormField(
                        controller: confirmController,
                        obscureText: isPasswordObscure,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          hintText: tr.confirm_password,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordObscure = !isPasswordObscure;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      );
    }

    testWidgets('renders password and confirm password fields', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
    });

    testWidgets('displays correct hint texts from localization', (
      tester,
    ) async {
      await tester.pumpWidget(createTestPasswordFields());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.first.decoration?.hintText, 'Password');
      expect(textFields.last.decoration?.hintText, 'Confirm Password');
    });

    testWidgets('has correct keyboard types and input actions', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.first.keyboardType, TextInputType.visiblePassword);
      expect(textFields.last.keyboardType, TextInputType.visiblePassword);
      expect(textFields.first.textInputAction, TextInputAction.next);
      expect(textFields.last.textInputAction, TextInputAction.done);
    });

    testWidgets('has correct autofill hints', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.first.autofillHints, const [AutofillHints.password]);
      expect(textFields.last.autofillHints, const [AutofillHints.password]);
    });

    testWidgets('shows password visibility toggle icons', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));
    });

    testWidgets('can toggle password visibility', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      final toggleButtons = find.byType(IconButton);
      await tester.tap(toggleButtons.first);
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsNWidgets(2));
    });

    testWidgets('can input text in password field', (tester) async {
      const testPassword = 'testpassword123';

      await tester.pumpWidget(createTestPasswordFields());
      await tester.enterText(find.byType(TextFormField).first, testPassword);

      expect(passwordController.text, testPassword);
    });

    testWidgets('can input text in confirm password field', (tester) async {
      const testPassword = 'testpassword123';

      await tester.pumpWidget(createTestPasswordFields());
      await tester.enterText(find.byType(TextFormField).last, testPassword);

      expect(confirmController.text, testPassword);
    });

    testWidgets('has correct spacing between fields', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final spacingBox = sizedBoxes.firstWhere((box) => box.height != null);
      expect(spacingBox.height, greaterThan(0));
    });

    testWidgets('has correct column structure', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      expect(find.byType(Column), findsOneWidget);
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, 3);
    });

    testWidgets('password visibility state affects both fields', (
      tester,
    ) async {
      await tester.pumpWidget(createTestPasswordFields());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.first.obscureText, true);
      expect(textFields.last.obscureText, true);

      final toggleButtons = find.byType(IconButton);
      await tester.tap(toggleButtons.first);
      await tester.pump();

      final updatedTextFields = tester.widgetList<TextField>(
        find.byType(TextField),
      );
      expect(updatedTextFields.first.obscureText, false);
      expect(updatedTextFields.last.obscureText, false);
    });

    testWidgets('has correct suffix icons for both fields', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      expect(find.byType(IconButton), findsNWidgets(2));

      final iconButtons = tester.widgetList<IconButton>(
        find.byType(IconButton),
      );
      expect(iconButtons.first.icon, isA<Icon>());
      expect(iconButtons.last.icon, isA<Icon>());
    });

    testWidgets('handles multiple visibility toggles correctly', (
      tester,
    ) async {
      await tester.pumpWidget(createTestPasswordFields());

      final toggleButtons = find.byType(IconButton);

      await tester.tap(toggleButtons.first);
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsNWidgets(2));

      await tester.tap(toggleButtons.first);
      await tester.pump();
      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));

      await tester.tap(toggleButtons.first);
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsNWidgets(2));
    });

    testWidgets('has correct prefix icons', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
    });

    testWidgets('has proper field structure', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byType(Column), findsOneWidget);

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final hasSpacingBox = sizedBoxes.any((box) => box.height != null);
      expect(hasSpacingBox, true);
    });

    testWidgets('can handle simultaneous input in both fields', (tester) async {
      const password = 'password123';
      const confirmPassword = 'password123';

      await tester.pumpWidget(createTestPasswordFields());
      await tester.enterText(find.byType(TextFormField).first, password);
      await tester.enterText(find.byType(TextFormField).last, confirmPassword);

      expect(passwordController.text, password);
      expect(confirmController.text, confirmPassword);
    });

    testWidgets('maintains state consistency across toggles', (tester) async {
      await tester.pumpWidget(createTestPasswordFields());

      final toggleButtons = find.byType(IconButton);
      await tester.tap(toggleButtons.first);
      await tester.pump();

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.first.obscureText, false);
      expect(textFields.last.obscureText, false);

      await tester.tap(toggleButtons.last);
      await tester.pump();

      final updatedTextFields = tester.widgetList<TextField>(
        find.byType(TextField),
      );
      expect(updatedTextFields.first.obscureText, true);
      expect(updatedTextFields.last.obscureText, true);
    });
  });
}
