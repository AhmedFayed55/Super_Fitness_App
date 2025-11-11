import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
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
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<HomeCubit>.value(
        value: mockHomeCubit,
        child: Scaffold(
          body: Builder(
            builder: (context) {
              final cubitState = state.todayData?.musclesDtoEntity ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Recommendation To Day'),
                  ),
                  const SizedBox(height: 8),
                  for (var muscle in cubitState)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Text(muscle.name),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  testWidgets('RecommendationToDay shows text items only', (tester) async {
    final mockMuscles = [
      MusclesDtoEntity(name: "Biceps", image: '', id: '1'),
      MusclesDtoEntity(name: "Triceps", image: '', id: '2'),
    ];

    final homeState = HomeState(
      today: ScreenStatus.isSuccess,
      todayData: MusclesRandomEntity(
        musclesDtoEntity: mockMuscles,
        message: "message",
        totalMuscles: 1,
      ),
    );

    when(mockHomeCubit.state).thenReturn(homeState);
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream<HomeState>.value(homeState));

    await tester.pumpWidget(createWidgetUnderTest(homeState));
    await tester.pumpAndSettle();

    expect(find.text('Recommendation To Day'), findsOneWidget);

    for (var muscle in mockMuscles) {
      expect(find.text(muscle.name), findsOneWidget);
    }
  });
}
