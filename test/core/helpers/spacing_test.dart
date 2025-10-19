import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';

void main() {
  testWidgets("verticalSpace returns a SizedBox with correct height", (
      tester,
      ) async {
    const double height = 20;

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: verticalSpace(height))),
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox.height, height);
    expect(sizedBox.width, isNull);
  });

  testWidgets("horizontalSpace returns a SizedBox with correct width", (
      tester,
      ) async {
    const double width = 15;

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: horizontalSpace(width))),
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox.width, width);
    expect(sizedBox.height, isNull);
  });
}