import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_blur_page_view.dart';

void main() {
  testWidgets('CustomBlurPageView blur', (
    WidgetTester tester,
  ) async {
    const testChild = Text('Test content');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CustomBlurPageView(child: testChild)),
      ),
    );

    expect(find.byType(CustomBlurPageView), findsOneWidget);

    final clipFinder = find.byType(ClipRRect);
    expect(clipFinder, findsOneWidget);

    final blurFinder = find.byType(BackdropFilter);
    expect(blurFinder, findsOneWidget);

    expect(find.text('Test content'), findsOneWidget);

    final BackdropFilter blurWidget = tester.widget(blurFinder);
    final ImageFilter filter = blurWidget.filter;

    expect(filter, isA<ImageFilter>());

    expect(AppConstants.blurValueRegister, greaterThan(0));

    final sizedBoxFinder = find.byType(SizedBox);
    expect(sizedBoxFinder, findsOneWidget);
    final SizedBox sizedBox = tester.widget(sizedBoxFinder);
    expect(sizedBox.width, double.infinity);
  });
}
