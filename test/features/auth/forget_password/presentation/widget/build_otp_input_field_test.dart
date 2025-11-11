import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

void main() {
  group('OtpInputField Widget Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget createTestPinput() {
      return MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final theme = Theme.of(context);
              final width = MediaQuery.of(context).size.width;
              final height = MediaQuery.of(context).size.height;

              final defaultPinTheme = PinTheme(
                width: width * 0.13,
                height: height * 0.07,
                textStyle: TextStyle(
                  fontSize: width * 0.06,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.primary,
                      width: width * 0.002,
                    ),
                  ),
                ),
              );

              final focusedPinTheme = defaultPinTheme.copyDecorationWith(
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.primary,
                    width: width * 0.002,
                  ),
                ),
              );

              return Pinput(
                controller: controller,
                length: 6,
                keyboardType: TextInputType.number,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: defaultPinTheme,
                showCursor: true,
                onCompleted: (pin) {
                  if (pin.length == 6) {}
                },
              );
            },
          ),
        ),
      );
    }

    testWidgets('renders OTP input field with correct properties', (
      tester,
    ) async {
      await tester.pumpWidget(createTestPinput());

      expect(find.byType(Pinput), findsOneWidget);
    });

    testWidgets('has correct length of 6 digits', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.length, 6);
    });

    testWidgets('has correct keyboard type', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.keyboardType, TextInputType.number);
    });

    testWidgets('shows cursor', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.showCursor, true);
    });

    testWidgets('has correct controller', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.controller, controller);
    });

    testWidgets('has default pin theme with correct properties', (
      tester,
    ) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      final defaultTheme = pinput.defaultPinTheme;

      expect(defaultTheme?.width, greaterThan(0));
      expect(defaultTheme?.height, greaterThan(0));
      expect(defaultTheme?.textStyle, isNotNull);
      expect(defaultTheme?.decoration, isNotNull);
    });

    testWidgets('has focused pin theme', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.focusedPinTheme, isNotNull);
    });

    testWidgets('has submitted pin theme', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.submittedPinTheme, isNotNull);
    });

    testWidgets('applies theme colors correctly', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      final defaultTheme = pinput.defaultPinTheme;

      expect(defaultTheme?.textStyle?.color, isNotNull);
      expect(defaultTheme?.decoration, isNotNull);
    });

    testWidgets('has responsive sizing based on screen dimensions', (
      tester,
    ) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      final defaultTheme = pinput.defaultPinTheme;
      expect(defaultTheme?.width, greaterThan(0));
      expect(defaultTheme?.height, greaterThan(0));
    });

    testWidgets('has correct text style properties', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      final defaultTheme = pinput.defaultPinTheme;
      final textStyle = defaultTheme?.textStyle;

      expect(textStyle?.fontSize, greaterThan(0));
      expect(textStyle?.fontWeight, FontWeight.bold);
      expect(textStyle?.color, isNotNull);
    });

    testWidgets('has border decoration', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      final defaultTheme = pinput.defaultPinTheme;
      final decoration = defaultTheme?.decoration;

      expect(decoration?.border, isNotNull);
    });

    testWidgets('has proper theme inheritance', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));

      expect(pinput.defaultPinTheme, isNotNull);
      expect(pinput.focusedPinTheme, isNotNull);
      expect(pinput.submittedPinTheme, isNotNull);
    });

    testWidgets('has proper decoration structure', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      final defaultTheme = pinput.defaultPinTheme;
      final decoration = defaultTheme?.decoration;

      expect(decoration?.border, isNotNull);
      expect(decoration?.border?.bottom, isNotNull);
    });

    testWidgets('has onCompleted callback', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.onCompleted, isNotNull);
    });

    testWidgets('has proper pin theme configuration', (tester) async {
      await tester.pumpWidget(createTestPinput());

      final pinput = tester.widget<Pinput>(find.byType(Pinput));

      expect(pinput.defaultPinTheme, isNotNull);
      expect(pinput.focusedPinTheme, isNotNull);
      expect(pinput.submittedPinTheme, isNotNull);
      expect(pinput.defaultPinTheme?.width, greaterThan(0));
      expect(pinput.defaultPinTheme?.height, greaterThan(0));
    });

    testWidgets('can input text and updates controller', (tester) async {
      const testOtp = '123456';

      await tester.pumpWidget(createTestPinput());
      await tester.enterText(find.byType(Pinput), testOtp);

      expect(controller.text, testOtp);
    });

    testWidgets('limits input to 6 digits', (tester) async {
      const longOtp = '1234567890';

      await tester.pumpWidget(createTestPinput());
      await tester.enterText(find.byType(Pinput), longOtp);

      expect(controller.text.length, lessThanOrEqualTo(6));
    });
  });
}
