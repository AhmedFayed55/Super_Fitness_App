import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_arrow_back.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ArrowBackButton renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ArrowBackButton())),
    );

    expect(find.byType(ArrowBackButton), findsOneWidget);

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ArrowBackButton triggers onTap when tapped', (tester) async {
    final mockCallback = MockCallback();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ArrowBackButton(onTap: mockCallback.call)),
      ),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    verify(mockCallback()).called(1);
  });
}
