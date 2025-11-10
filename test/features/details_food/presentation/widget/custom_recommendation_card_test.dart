import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_recommendation_card.dart';

class MockImageProvider extends Mock implements ImageProvider<Object> {}

void main() {
  const testTitle = 'Grilled Chicken Salad';
  const testImageUrl = 'https://example.com/image.jpg';

  Widget buildTestWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  testWidgets('displays title and image correctly', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        const CustomRecommendationCard(
          title: testTitle,
          imagePath: testImageUrl,
        ),
      ),
    );

    expect(find.textContaining('Grilled Chicken'), findsOneWidget);
    expect(find.textContaining('Salad'), findsOneWidget);

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('shows placeholder while loading image', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        const CustomRecommendationCard(
          title: testTitle,
          imagePath: testImageUrl,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  test('🧩 formatMealTitle splits text into two lines correctly', () {
    const title = 'Grilled Chicken Salad with Avocado';
    final formatted = formatMealTitle(title);

    expect(formatted, 'Grilled Chicken\nSalad with Avocado');
  });
}
