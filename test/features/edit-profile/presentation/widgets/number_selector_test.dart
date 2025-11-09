import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/number_selector.dart';

import 'number_selector_test.mocks.dart';

abstract class OnChangedCallback {
  void call(int value);
}

abstract class OnPressedCallback {
  void call();
}

@GenerateMocks([OnChangedCallback, OnPressedCallback])
void main() {
  late MockOnChangedCallback mockOnChanged;
  late MockOnPressedCallback mockOnPressed;

  setUp(() {
    mockOnChanged = MockOnChangedCallback();
    mockOnPressed = MockOnPressedCallback();
  });

  Widget buildWidget() {
    return MaterialApp(
      home: Scaffold(
        body: SelectNumber(
          value: 70,
          min: 50,
          max: 120,
          onChanged: mockOnChanged.call,
          onPressed: mockOnPressed.call,
          buttonText: "Done",
        ),
      ),
    );
  }

  testWidgets('renders NumberPicker with correct initial value', (
    tester,
  ) async {
    await tester.pumpWidget(buildWidget());

    final numberPicker = find.byType(NumberPicker);
    expect(numberPicker, findsOneWidget);

    final widget = tester.widget<NumberPicker>(numberPicker);
    expect(widget.value, 70);
  });

  testWidgets('calls onChanged when value is changed', (tester) async {
    await tester.pumpWidget(buildWidget());

    final numberPicker = find.byType(NumberPicker);

 
    (tester.widget(numberPicker) as NumberPicker).onChanged(75);
    await tester.pump();

    verify(mockOnChanged.call(75)).called(1);
  });

  testWidgets('calls onPressed when button is tapped', (tester) async {
    await tester.pumpWidget(buildWidget());
    await tester.tap(find.text('Done'));
    await tester.pump();

    verify(mockOnPressed.call()).called(1);
  });
}
