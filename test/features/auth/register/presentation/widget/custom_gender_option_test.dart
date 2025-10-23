import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_gender_option.dart';

void main() {
  testWidgets('CustomGenderOption يعرض بشكل صحيح وينفذ onTap عند الضغط', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomGenderOption(
            selected: true,
            icon: Icons.male,
            label: 'Male',
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    // تحقق من وجود النص
    expect(find.text('Male'), findsOneWidget);

    // تحقق من وجود الأيقون
    expect(find.byIcon(Icons.male), findsOneWidget);

    // تحقق من الخصائص البصرية
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, isNotNull);

    // تحقق من تنفيذ onTap عند الضغط
    await tester.tap(find.byType(CustomGenderOption));
    await tester.pumpAndSettle();
    expect(wasTapped, isTrue);
  });
}
