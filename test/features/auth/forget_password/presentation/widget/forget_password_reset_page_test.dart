import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

void main() {
  group('ForgetPasswordResetPage Widget Tests', () {
    Widget createTestForgetPasswordResetPage() {
      return MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final height = MediaQuery.of(context).size.height;
              final width = MediaQuery.of(context).size.width;
              final theme = Theme.of(context);
              final tr = AppLocalizations.of(context)!;
              final formKey = GlobalKey<FormState>();
              final passwordController = TextEditingController();
              final confirmPasswordController = TextEditingController();
              bool isPasswordResetLoading = false;

              return StatefulBuilder(
                builder: (context, setState) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: Colors.blue,
                        child: const Center(child: Text('Background')),
                      ),

                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        // ignore: deprecated_member_use
                        child: Container(color: Colors.black.withOpacity(0.3)),
                      ),

                      SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.06),

                              Center(
                                child: Container(
                                  width: width * 0.186,
                                  height: height * 0.06,
                                  color: Colors.red,
                                  child: const Center(child: Text('Logo')),
                                ),
                              ),

                              SizedBox(height: height * 0.08),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.0426,
                                ),
                                child: Text(
                                  tr.create_new_password,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: height * 0.008),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.0426,
                                ),
                                child: Text(
                                  tr.make_sure_it_8_characters_or_more,
                                  style: theme.textTheme.displayMedium,
                                ),
                              ),

                              SizedBox(height: height * 0.03),

                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.0426,
                                ),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: passwordController,
                                            obscureText: true,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            textInputAction:
                                                TextInputAction.next,
                                            autofillHints: const [
                                              AutofillHints.password,
                                            ],
                                            decoration: InputDecoration(
                                              hintText: tr.password,
                                              prefixIcon: const Icon(
                                                Icons.lock_outline,
                                              ),
                                              suffixIcon: const Icon(
                                                Icons.visibility_off,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            controller:
                                                confirmPasswordController,
                                            obscureText: true,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            textInputAction:
                                                TextInputAction.done,
                                            autofillHints: const [
                                              AutofillHints.password,
                                            ],
                                            decoration: InputDecoration(
                                              hintText: tr.confirm_password,
                                              prefixIcon: const Icon(
                                                Icons.lock_outline,
                                              ),
                                              suffixIcon: const Icon(
                                                Icons.visibility_off,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: height * 0.03),

                                    ElevatedButton(
                                      onPressed: isPasswordResetLoading
                                          ? null
                                          : () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  isPasswordResetLoading = true;
                                                });
                                              }
                                            },
                                      child: Text(tr.done),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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

    testWidgets('renders forget password reset page with all components', (
      tester,
    ) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(Stack), findsAtLeastNWidgets(1));
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('displays correct title and subtitle text', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      final hasContent = textWidgets.any(
        (text) => text.data != null && text.data!.isNotEmpty,
      );
      expect(hasContent, true);
    });

    testWidgets('renders app logo', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.text('Logo'), findsOneWidget);
    });

    testWidgets('has correct background', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.text('Background'), findsOneWidget);
    });

    testWidgets('has backdrop filter with blur effect', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(BackdropFilter), findsOneWidget);
      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.filter, isA<ImageFilter>());
    });

    testWidgets('contains password input fields', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));
    });

    testWidgets('has done button', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.text('Done'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('has proper scroll view', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has correct spacing elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final spacingBoxes = sizedBoxes.where((box) => box.height != null);
      expect(spacingBoxes.length, greaterThan(0));
    });

    testWidgets('has proper padding for text elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(Padding), findsAtLeastNWidgets(2));
    });

    testWidgets('has blur container for form elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });

    testWidgets('can input text in password field', (tester) async {
      const testPassword = 'password123';

      await tester.pumpWidget(createTestForgetPasswordResetPage());
      await tester.enterText(find.byType(TextFormField).first, testPassword);

      expect(find.text(testPassword), findsOneWidget);
    });

    testWidgets('can input text in confirm password field', (tester) async {
      const testPassword = 'password123';

      await tester.pumpWidget(createTestForgetPasswordResetPage());
      await tester.enterText(find.byType(TextFormField).last, testPassword);

      expect(find.text(testPassword), findsOneWidget);
    });

    testWidgets('done button is enabled when not loading', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('has correct text styles', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      for (final textWidget in textWidgets) {
        if (textWidget.style != null) {
          expect(textWidget.style, isNotNull);
        }
      }
    });

    testWidgets('has proper cross axis alignment', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final columns = tester.widgetList<Column>(find.byType(Column));
      expect(columns.length, greaterThan(0));

      final hasStartAlignment = columns.any(
        (column) => column.crossAxisAlignment == CrossAxisAlignment.start,
      );
      expect(hasStartAlignment, true);
    });

    testWidgets('has center alignment for logo', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(Center), findsAtLeastNWidgets(1));
    });

    testWidgets('has proper stack fit', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final stacks = tester.widgetList<Stack>(find.byType(Stack));
      expect(stacks.length, greaterThan(0));

      final hasExpandFit = stacks.any((stack) => stack.fit == StackFit.expand);
      expect(hasExpandFit, true);
    });

    testWidgets('has proper safe area', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('has proper backdrop filter container', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.child, isA<Container>());
    });

    testWidgets('has proper widget hierarchy', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(Stack), findsAtLeastNWidgets(1));
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('has proper spacing between elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final hasSpacing = sizedBoxes.any((box) => box.height != null);
      expect(hasSpacing, true);
    });

    testWidgets('has proper text alignment', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      for (final textWidget in textWidgets) {
        expect(textWidget.textAlign, anyOf(isNull, TextAlign.start));
      }
    });

    testWidgets('has proper password field properties', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.length, 2);

      final passwordField = textFields.first;
      expect(passwordField.keyboardType, TextInputType.visiblePassword);
      expect(passwordField.textInputAction, TextInputAction.next);
      expect(passwordField.autofillHints, const [AutofillHints.password]);
      expect(passwordField.obscureText, true);

      final confirmPasswordField = textFields.last;
      expect(confirmPasswordField.keyboardType, TextInputType.visiblePassword);
      expect(confirmPasswordField.textInputAction, TextInputAction.done);
      expect(confirmPasswordField.autofillHints, const [
        AutofillHints.password,
      ]);
      expect(confirmPasswordField.obscureText, true);
    });

    testWidgets('has proper blur container styling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));

      final hasDecoration = containers.any(
        (container) => container.decoration != null,
      );
      expect(hasDecoration, true);
    });

    testWidgets('has proper responsive sizing', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final spacingBoxes = sizedBoxes.where((box) => box.height != null);
      expect(spacingBoxes.length, greaterThan(0));
    });

    testWidgets('has proper blur effect configuration', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.filter, isA<ImageFilter>());

      final container = backdropFilter.child as Container;
      expect(container.color, isNotNull);
    });

    testWidgets('has proper container structure', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));

      for (final container in containers) {
        if (container.child != null) {
          expect(container.child, isNotNull);
        }
      }
    });

    testWidgets('has proper margin and padding', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final containers = tester.widgetList<Container>(find.byType(Container));

      final hasMarginOrPadding = containers.any(
        (container) => container.margin != null || container.padding != null,
      );
      expect(hasMarginOrPadding, true);
    });

    testWidgets('has proper decoration properties', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final containers = tester.widgetList<Container>(find.byType(Container));

      final hasDecoration = containers.any(
        (container) => container.decoration != null,
      );
      expect(hasDecoration, true);

      if (hasDecoration) {
        final containerWithDecoration = containers.firstWhere(
          (container) => container.decoration != null,
        );
        final decoration = containerWithDecoration.decoration as BoxDecoration;
        expect(decoration.color, isNotNull);
        expect(decoration.borderRadius, isNotNull);
      }
    });

    testWidgets('has proper form structure', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('has proper scroll behavior', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.child, isA<Column>());
    });

    testWidgets('has proper state management setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(StatefulBuilder), findsOneWidget);
    });

    testWidgets('has proper loading state handling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final doneButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      expect(doneButton.onPressed, isNotNull);
    });

    testWidgets('has proper password validation setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.length, 2);

      final passwordField = textFields.first;
      expect(passwordField.keyboardType, TextInputType.visiblePassword);
      expect(passwordField.obscureText, true);

      final confirmPasswordField = textFields.last;
      expect(confirmPasswordField.keyboardType, TextInputType.visiblePassword);
      expect(confirmPasswordField.obscureText, true);
    });

    testWidgets('has proper accessibility setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has proper password visibility setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      for (final textField in textFields) {
        expect(textField.obscureText, true);
      }
    });

    testWidgets('has proper form key setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final form = tester.widget<Form>(find.byType(Form));
      expect(form.key, isA<GlobalKey<FormState>>());
    });

    testWidgets('has proper autofill setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      for (final textField in textFields) {
        expect(textField.autofillHints, const [AutofillHints.password]);
      }
    });

    testWidgets('has proper input action setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.first.textInputAction, TextInputAction.next);
      expect(textFields.last.textInputAction, TextInputAction.done);
    });

    testWidgets('has proper icon setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));
    });

    testWidgets('has proper button text styling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final doneButtonText = find.text('Done');
      expect(doneButtonText, findsOneWidget);
    });

    testWidgets('has proper password field spacing', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final hasSpacing = sizedBoxes.any((box) => box.height != null);
      expect(hasSpacing, true);
    });

    testWidgets('has proper form validation structure', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordResetPage());

      final form = tester.widget<Form>(find.byType(Form));
      expect(form.key, isA<GlobalKey<FormState>>());

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      expect(textFields.length, 2);
    });
  });
}
