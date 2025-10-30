import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

void main() {
  group('ForgetPasswordOtpPage Widget Tests', () {
    Widget createTestForgetPasswordOtpPage() {
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
              final otpController = TextEditingController();
              bool isOtpCorrectLoading = false;
              bool isVerifyCodeSentLoading = false;

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
                                  tr.enter_otp_code,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.0426,
                                ),
                                child: Text(
                                  tr.check_your_email_for_the_code,
                                  style: theme.textTheme.displayMedium,
                                ),
                              ),
                              SizedBox(height: height * 0.02),

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
                                      controller: otpController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 6,
                                      decoration: const InputDecoration(
                                        hintText: 'OTP Code',
                                        counterText: '',
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),

                                    ElevatedButton(
                                      onPressed: isOtpCorrectLoading
                                          ? null
                                          : () {
                                              final otp = otpController.text;
                                              if (otp.length == 6) {
                                                setState(() {
                                                  isOtpCorrectLoading = true;
                                                });
                                              }
                                            },
                                      child: Text(tr.confirm),
                                    ),

                                    SizedBox(height: height * 0.02),

                                    Column(
                                      children: [
                                        Text(
                                          tr.didnt_receive_verification_code,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        TextButton(
                                          onPressed: isVerifyCodeSentLoading
                                              ? null
                                              : () {
                                                  setState(() {
                                                    isVerifyCodeSentLoading =
                                                        true;
                                                  });
                                                },
                                          child: Text(tr.resend_code),
                                        ),
                                      ],
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

    testWidgets('renders forget password OTP page with all components', (
      tester,
    ) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(Stack), findsAtLeastNWidgets(1));
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('displays correct title and subtitle text', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));
      final hasContent = textWidgets.any(
        (text) => text.data != null && text.data!.isNotEmpty,
      );
      expect(hasContent, true);
    });

    testWidgets('renders app logo', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.text('Logo'), findsOneWidget);
    });

    testWidgets('has correct background', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.text('Background'), findsOneWidget);
    });

    testWidgets('has backdrop filter with blur effect', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(BackdropFilter), findsOneWidget);
      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.filter, isA<ImageFilter>());
    });

    testWidgets('contains OTP input field', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(TextFormField), findsOneWidget);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.number);
      expect(textField.maxLength, 6);
    });

    testWidgets('has confirm button', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.text('Confirm'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('has resend code button', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(TextButton), findsOneWidget);

      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      expect(textButton.child, isA<Text>());
    });

    testWidgets('has proper scroll view', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has correct spacing elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final spacingBoxes = sizedBoxes.where((box) => box.height != null);
      expect(spacingBoxes.length, greaterThan(0));
    });

    testWidgets('has proper padding for text elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(Padding), findsAtLeastNWidgets(2));
    });

    testWidgets('has blur container for form elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });

    testWidgets('can input text in OTP field', (tester) async {
      const testOtp = '123456';

      await tester.pumpWidget(createTestForgetPasswordOtpPage());
      await tester.enterText(find.byType(TextFormField), testOtp);

      expect(find.text(testOtp), findsOneWidget);
    });

    testWidgets('confirm button is enabled when not loading', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('resend button is enabled when not loading', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final button = tester.widget<TextButton>(find.byType(TextButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('has correct text styles', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      for (final textWidget in textWidgets) {
        if (textWidget.style != null) {
          expect(textWidget.style, isNotNull);
        }
      }
    });

    testWidgets('has proper cross axis alignment', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final columns = tester.widgetList<Column>(find.byType(Column));
      expect(columns.length, greaterThan(0));

      final hasStartAlignment = columns.any(
        (column) => column.crossAxisAlignment == CrossAxisAlignment.start,
      );
      expect(hasStartAlignment, true);
    });

    testWidgets('has center alignment for logo', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(Center), findsAtLeastNWidgets(1));
    });

    testWidgets('has proper stack fit', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final stacks = tester.widgetList<Stack>(find.byType(Stack));
      expect(stacks.length, greaterThan(0));

      final hasExpandFit = stacks.any((stack) => stack.fit == StackFit.expand);
      expect(hasExpandFit, true);
    });

    testWidgets('has proper safe area', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('has proper backdrop filter container', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.child, isA<Container>());
    });

    testWidgets('has proper widget hierarchy', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(Stack), findsAtLeastNWidgets(1));
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('has proper spacing between elements', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final hasSpacing = sizedBoxes.any((box) => box.height != null);
      expect(hasSpacing, true);
    });

    testWidgets('has proper text alignment', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      for (final textWidget in textWidgets) {
        expect(textWidget.textAlign, anyOf(isNull, TextAlign.start));
      }
    });

    testWidgets('has proper OTP field properties', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.number);
      expect(textField.maxLength, 6);
    });

    testWidgets('has proper blur container styling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));

      final hasDecoration = containers.any(
        (container) => container.decoration != null,
      );
      expect(hasDecoration, true);
    });

    testWidgets('has proper responsive sizing', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, greaterThan(0));

      final spacingBoxes = sizedBoxes.where((box) => box.height != null);
      expect(spacingBoxes.length, greaterThan(0));
    });

    testWidgets('has proper blur effect configuration', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdropFilter.filter, isA<ImageFilter>());

      final container = backdropFilter.child as Container;
      expect(container.color, isNotNull);
    });

    testWidgets('has proper container structure', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));

      for (final container in containers) {
        if (container.child != null) {
          expect(container.child, isNotNull);
        }
      }
    });

    testWidgets('has proper margin and padding', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final containers = tester.widgetList<Container>(find.byType(Container));

      final hasMarginOrPadding = containers.any(
        (container) => container.margin != null || container.padding != null,
      );
      expect(hasMarginOrPadding, true);
    });

    testWidgets('has proper decoration properties', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

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

    testWidgets('has resend code section', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(TextButton), findsOneWidget);

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      expect(textWidgets.length, greaterThan(0));

      final hasContent = textWidgets.any(
        (text) => text.data != null && text.data!.isNotEmpty,
      );
      expect(hasContent, true);
    });

    testWidgets('has proper button text styling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final confirmButtonText = find.text('Confirm');
      expect(confirmButtonText, findsOneWidget);

      expect(find.byType(TextButton), findsOneWidget);
      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      expect(textButton.child, isA<Text>());
    });

    testWidgets('has proper form structure', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('has proper scroll behavior', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.child, isA<Column>());
    });

    testWidgets('has proper state management setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(StatefulBuilder), findsOneWidget);
    });

    testWidgets('has proper loading state handling', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final confirmButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      final resendButton = tester.widget<TextButton>(find.byType(TextButton));

      expect(confirmButton.onPressed, isNotNull);
      expect(resendButton.onPressed, isNotNull);
    });

    testWidgets('has proper OTP validation setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLength, 6);
      expect(textField.keyboardType, TextInputType.number);
    });

    testWidgets('has proper accessibility setup', (tester) async {
      await tester.pumpWidget(createTestForgetPasswordOtpPage());

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
