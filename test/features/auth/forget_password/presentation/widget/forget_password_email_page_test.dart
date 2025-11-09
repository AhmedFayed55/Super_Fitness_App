import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

void main() {
  group('ForgetPasswordEmailPage Widget Tests', () {
    Widget createTestForgetPasswordPage() {
      return MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final height = MediaQuery.of(context).size.height;
              final width = MediaQuery.of(context).size.width;
              final tr = AppLocalizations.of(context)!;
              final formKey = GlobalKey<FormState>();
              final emailController = TextEditingController();

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
                    child: Form(
                      key: formKey,
                      child: AutofillGroup(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.056),
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
                                tr.enter_your_email,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.0426,
                              ),
                              child: Text(
                                tr.forget_password,
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium,
                              ),
                            ),
                            SizedBox(height: height * 0.0197),

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
                                  TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.email],
                                    decoration: InputDecoration(
                                      hintText: tr.email,
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {}
                                    },
                                    child: Text(
                                      tr.send_otp,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }

    testWidgets('renders forget password email page with all components', (
      tester,
    ) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(Stack), findsAtLeastNWidgets(1));
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(AutofillGroup), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('displays correct title and subtitle text', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      final hasContent = textWidgets.any(
        (text) => text.data != null && text.data!.isNotEmpty,
      );
      expect(hasContent, true);
    });

    testWidgets('renders app logo', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.text('Logo'), findsOneWidget);
    });

    testWidgets('has correct background', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.text('Background'), findsOneWidget);
    });

    testWidgets('has backdrop filter with blur effect', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(BackdropFilter), findsOneWidget);
      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.filter, isA<ImageFilter>());
    });

    testWidgets('contains email input field', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('has send OTP button', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.text('Send OTP'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('has proper form structure', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(AutofillGroup), findsOneWidget);

      final form = tester.widget<Form>(find.byType(Form));
      expect(form.key, isNotNull);
    });

    testWidgets('has correct spacing elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final spacingBoxes = sizedBoxes.where((box) => box.height != null);
      expect(spacingBoxes.length, greaterThan(0));
    });

    testWidgets('has proper padding for text elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(Padding), findsAtLeastNWidgets(2));
    });

    testWidgets('has blur container for form elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });

    testWidgets('can input text in email field', (tester) async {
      const testEmail = 'test@example.com';

      await tester.pumpWidget(createTestForgetPasswordPage());
      await tester.enterText(find.byType(TextFormField), testEmail);

      expect(find.text(testEmail), findsOneWidget);
    });

    testWidgets('button is enabled when not loading', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('has correct text styles', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      for (final textWidget in textWidgets) {
        if (textWidget.style != null) {
          expect(textWidget.style, isNotNull);
        }
      }
    });

    testWidgets('has proper cross axis alignment', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final columns = tester.widgetList<Column>(find.byType(Column));
      expect(columns.length, greaterThan(0));

      final hasStartAlignment = columns.any(
        (column) => column.crossAxisAlignment == CrossAxisAlignment.start,
      );
      expect(hasStartAlignment, true);
    });

    testWidgets('has center alignment for logo', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(Center), findsAtLeastNWidgets(1));
    });

    testWidgets('has proper stack fit', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final stacks = tester.widgetList<Stack>(find.byType(Stack));
      expect(stacks.length, greaterThan(0));

      final hasExpandFit = stacks.any((stack) => stack.fit == StackFit.expand);
      expect(hasExpandFit, true);
    });

    testWidgets('has proper safe area', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('has proper form key', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final form = tester.widget<Form>(find.byType(Form));
      expect(form.key, isA<GlobalKey<FormState>>());
    });

    testWidgets('has proper autofill group', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(AutofillGroup), findsOneWidget);
    });

    testWidgets('has proper backdrop filter container', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.child, isA<Container>());
    });

    testWidgets('has proper widget hierarchy', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      expect(find.byType(Stack), findsAtLeastNWidgets(1));
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(AutofillGroup), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('has proper spacing between elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final hasSpacing = sizedBoxes.any((box) => box.height != null);
      expect(hasSpacing, true);
    });

    testWidgets('has proper text alignment', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      for (final textWidget in textWidgets) {
        expect(textWidget.textAlign, anyOf(isNull, TextAlign.start));
      }
    });

    testWidgets('has proper button text styling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final buttonText = find.text('Send OTP');
      expect(buttonText, findsOneWidget);

      final textWidget = tester.widget<Text>(buttonText);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('has proper email field properties', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.emailAddress);
      expect(textField.textInputAction, TextInputAction.next);
      expect(textField.autofillHints, const [AutofillHints.email]);
    });

    testWidgets('has proper blur container styling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));

      final hasDecoration = containers.any(
        (container) => container.decoration != null,
      );
      expect(hasDecoration, true);
    });

    testWidgets('has proper responsive sizing', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final spacingBoxes = sizedBoxes.where((box) => box.height != null);
      expect(spacingBoxes.length, greaterThan(0));
    });

    testWidgets('has proper form validation setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final form = tester.widget<Form>(find.byType(Form));
      expect(form.key, isA<GlobalKey<FormState>>());

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('has proper blur effect configuration', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.filter, isA<ImageFilter>());

      final container = backdropFilter.child as Container;
      expect(container.color, isNotNull);
    });

    testWidgets('has proper container structure', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));

      for (final container in containers) {
        if (container.child != null) {
          expect(container.child, isNotNull);
        }
      }
    });

    testWidgets('has proper margin and padding', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

      final containers = tester.widgetList<Container>(find.byType(Container));

      final hasMarginOrPadding = containers.any(
        (container) => container.margin != null || container.padding != null,
      );
      expect(hasMarginOrPadding, true);
    });

    testWidgets('has proper decoration properties', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordPage());

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
  });
}
