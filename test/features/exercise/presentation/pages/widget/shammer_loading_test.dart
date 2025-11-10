import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/shammer_loading.dart';

void main() {
  testWidgets('renders ExerciseShimmerScreen correctly', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ExerciseShimmerScreen()));

    await tester.pump();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Container), findsWidgets);

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    expect(find.byType(ListView), findsOneWidget);

    expect(tester.takeException(), isNull);
  });
}
