import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/tab_item.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/config/theme/colors.dart';

void main() {
  testWidgets('TabItem shows name and correct background color', (
    tester,
  ) async {
    final muscle = MusclesGroupDtoEntity(name: 'name', id: 'id');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TabItem(musclesGroupDtoEntity: muscle, selected: true),
        ),
      ),
    );

    expect(find.text('name'), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, AppColors.lightOrange[10]);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TabItem(musclesGroupDtoEntity: muscle, selected: false),
        ),
      ),
    );

    final container2 = tester.widget<Container>(find.byType(Container));
    final decoration2 = container2.decoration as BoxDecoration;
    expect(decoration2.color, Colors.transparent);
  });
}
