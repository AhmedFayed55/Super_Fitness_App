import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_bar_text.dart';

void main() {
  testWidgets('CustomBarText displays text1 and text2 correctly', (tester) async {
    const text1 = 'Hello';
    const text2 = 'World';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomBarText(text1: text1, text2: text2),
        ),
      ),
    );

    expect(find.text(text1), findsOneWidget);
    expect(find.text(text2), findsOneWidget);

    expect(find.byType(Text), findsNWidgets(2));

    final textWidget1 = tester.widget<Text>(find.text(text1));
    expect(textWidget1.style!.fontSize, 20);

    final textWidget2 = tester.widget<Text>(find.text(text2));
    expect(textWidget2.style, isNotNull);
  });
}