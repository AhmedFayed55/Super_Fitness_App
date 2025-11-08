import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/meal_grid_view_item_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MealGridViewItemWidget Tests', () {
    testWidgets('View title and placeholder correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MealGridViewItemWidget(
              title: 'Grilled Chicken Breast',
              imagePath: 'https:fake_image.jpg',
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Grilled Chicken\nBreast'), findsOneWidget);

      expect(find.byType(CachedNetworkImage), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    test('formatMealTitle splits long titles correctly', () {
      const title = 'Chicken Teriyaki Bowl Deluxe';

      final result = formatMealTitle(title);

      expect(result, 'Chicken Teriyaki\nBowl Deluxe');
    });

    test('formatMealTitle returns short title unchanged', () {
      const title = 'Chicken Bowl';

      final result = formatMealTitle(title);

      expect(result, 'Chicken Bowl');
    });
  });
}
