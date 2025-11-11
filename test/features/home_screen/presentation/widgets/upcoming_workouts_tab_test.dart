import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/upcoming_workouts_tab.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

import 'recommendation_for_you_test.mocks.dart';


@GenerateMocks([HomeCubit])
void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  Widget createWidgetUnderTest(HomeState state) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider<HomeCubit>.value(
        value: mockHomeCubit,
        child: const Scaffold(body: UpcomingWorkoutsTab()),
      ),
    );
  }

  testWidgets('UpcomingWorkoutsTab shows title, see all and tabs', (
    tester,
  ) async {
    final musclesGroups = [
      MusclesGroupDtoEntity(id: '1', name: 'Arms'),
      MusclesGroupDtoEntity(id: '2', name: 'Legs'),
    ];

    final homeState = HomeState(
      upcomingTabData: GetAllMusclesEntity(
        musclesGroupDtoEntity: musclesGroups,
        message: "message",
      ),
    );

    when(mockHomeCubit.state).thenReturn(homeState);
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream<HomeState>.value(homeState));

    await tester.pumpWidget(createWidgetUnderTest(homeState));
    await tester.pumpAndSettle();

    expect(find.textContaining('Upcoming Workouts'), findsOneWidget);

    expect(find.textContaining('See All'), findsOneWidget);

    for (var group in musclesGroups) {
      expect(find.text(group.name), findsOneWidget);
    }
  });
}
