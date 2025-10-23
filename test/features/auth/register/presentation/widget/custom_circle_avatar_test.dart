import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_circle_avatar.dart';

void main() {
  testWidgets('CustomCircleAvatar uses colorScheme.secondary as background', (
    WidgetTester tester,
  ) async {
    const testIcon = Icons.favorite;
    const testSecondaryColor = Colors.purple;

    final theme = ThemeData(
      colorScheme: const ColorScheme.light(secondary: testSecondaryColor),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: const Scaffold(body: CustomCircleAvatar(testIcon)),
      ),
    );

    expect(find.byType(CustomCircleAvatar), findsOneWidget);

    expect(find.byType(CircleAvatar), findsOneWidget);

    expect(find.byIcon(testIcon), findsOneWidget);

    final circleAvatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
    expect(circleAvatar.backgroundColor, testSecondaryColor);
  });
}
