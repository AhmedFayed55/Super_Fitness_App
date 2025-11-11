import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/custom_circlure_shape.dart';

void main() {
  testWidgets('CustomCirclureShape renders correctly with given child', (
    WidgetTester tester,
  ) async {
    // Arrange
    const testKey = Key('test_text');
    const testText = 'Circle Child';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomCirclureShape(child: Text(testText, key: testKey)),
        ),
      ),
    );

    // Assert
    expect(find.byType(CustomCirclureShape), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
    expect(find.text(testText), findsOneWidget);

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(CustomCirclureShape),
        matching: find.byType(Container),
      ),
    );

    final decoration = container.decoration as BoxDecoration;

    expect(decoration.borderRadius, isNotNull);
    expect(decoration.border, isNotNull);
    expect(decoration.border!.top.width, 0.5);
    expect(decoration.border!.top.color, Colors.white);
  });
}
