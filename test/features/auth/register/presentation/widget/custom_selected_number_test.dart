import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_selected_number.dart';

void main() {
  testWidgets('SelectNumber widget displays label and button', (WidgetTester tester) async {
    
    int selectedValue = 5;

  
    await tester.pumpWidget(
      MaterialApp(
        home: SelectNumber(
          label: 'Select Age',
          value: selectedValue,
          min: 1,
          max: 100,
          buttonText: 'Next',
          onChanged: (val) {
            selectedValue = val;
          },
          onPressed: () {},
        ),
      ),
    );

  
    expect(find.text('Select Age'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.byType(NumberPicker), findsOneWidget);

  
    final widget = tester.widget<SelectNumber>(find.byType(SelectNumber));
    widget.onChanged(10);
    expect(selectedValue, equals(10));
  });
}
