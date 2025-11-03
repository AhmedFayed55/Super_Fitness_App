import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/loading_widget.dart';

void main() {
  testWidgets('PopularTrainingShimmer builds correct shimmer list', (
    tester,
  ) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PopularTrainingShimmer())),
    );

    // Act
    final listViewFinder = find.byType(ListView);
    final shimmerFinder = find.byType(Shimmer);
    final containerFinder = find.byType(Container);

    // Assert
    expect(
      listViewFinder,
      findsOneWidget,
      reason: 'Should contain one horizontal ListView',
    );
    expect(
      shimmerFinder,
      findsNWidgets(2),
      reason: 'Should have 2 shimmer items',
    );

    final shimmerWidgets = tester.widgetList<Shimmer>(shimmerFinder);
    for (final shimmerWidget in shimmerWidgets) {
      expect(shimmerWidget.gradient, isNotNull);
      expect(shimmerWidget.child, isNotNull);
    }

    expect(containerFinder, findsWidgets);
  });
}
