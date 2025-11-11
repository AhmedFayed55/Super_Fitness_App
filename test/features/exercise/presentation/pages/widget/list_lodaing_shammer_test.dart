import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/list_lodaing_shammer.dart';

void main() {
  testWidgets('renders ExerciseListShimmer correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ExerciseListShimmer())),
    );

    await tester.pump();

    expect(find.byType(Shimmer), findsOneWidget);

    expect(find.byType(ListView), findsOneWidget);

    expect(find.byType(Container), findsWidgets);

    expect(tester.takeException(), isNull);
  });
}
