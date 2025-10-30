import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/get_all_muscles_response_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/muscles_group_id_response_usecase.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_event.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_view_model.dart';

import 'workouts_view_model_test.mocks.dart';

@GenerateMocks([GetAllMusclesResponseUseCase, MusclesGroupIdResponseUseCase])
void main() {
  late MockGetAllMusclesResponseUseCase mockGetAllMusclesResponseUseCase;
  late MockMusclesGroupIdResponseUseCase mockMusclesGroupIdResponseUseCase;
  late WorkoutsViewModel vm;

  setUpAll(() {
    provideDummy<ApiResult<dynamic>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });
  setUpAll(() {
    provideDummy<ApiResult<GetAllMusclesEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );

    provideDummy<ApiResult<MusclesGroupIdEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });

  setUp(() {
    mockGetAllMusclesResponseUseCase = MockGetAllMusclesResponseUseCase();
    mockMusclesGroupIdResponseUseCase = MockMusclesGroupIdResponseUseCase();
    vm = WorkoutsViewModel(
      mockGetAllMusclesResponseUseCase,
      mockMusclesGroupIdResponseUseCase,
    );
  });

  tearDown(() async {
    await vm.close();
  });

  final muscleGroup = MusclesGroupDtoEntity(id: '1', name: 'Chest');
  final selectedGroup = MuscleGroupDtoEntity(id: '1', name: 'Chest');
  final exercise = MusclesDtoEntity(
    id: 'ex1',
    name: 'Push Up',
    image: 'pushup.png',
  );

  final musclesResponse = ApiSuccessResult(
    data: GetAllMusclesEntity(
      message: 'ok',
      musclesGroupDtoEntity: [muscleGroup],
    ),
  );

  final muscleGroupResponse = ApiSuccessResult(
    data: MusclesGroupIdEntity(
      message: 'ok',
      muscleGroupDtoEntity: selectedGroup,
      musclesDtoEntity: [exercise],
    ),
  );

  group('WorkoutsViewModel Tests', () {
    test(
      'LoadMuscleGroupsEvent success loads groups and first group exercises',
      () async {
        when(
          mockGetAllMusclesResponseUseCase.call(),
        ).thenAnswer((_) async => musclesResponse);
        when(
          mockMusclesGroupIdResponseUseCase.call(any),
        ).thenAnswer((_) async => muscleGroupResponse);

        await vm.doIntent(LoadMuscleGroupsEvent());

        expect(vm.state.isLoadingGroups, false);
        expect(vm.state.muscleGroups, isNotEmpty);
        expect(vm.state.muscleGroups.first.name, 'Chest');
        expect(vm.state.exercises.first.name, 'Push Up');
        expect(vm.state.error, isNull);
      },
    );

    test(
      'LoadMuscleGroupsEvent error emits state with error message',
      () async {
        when(mockGetAllMusclesResponseUseCase.call()).thenAnswer(
          (_) async => ApiErrorResult(
            failure: Failure(errorMessage: 'failed to load groups'),
          ),
        );

        await vm.doIntent(LoadMuscleGroupsEvent());

        expect(vm.state.isLoadingGroups, false);
        expect(vm.state.error, 'failed to load groups');
      },
    );

    test(
      'SelectMuscleGroupEvent success updates exercises and caches them',
      () async {
        when(
          mockMusclesGroupIdResponseUseCase.call(any),
        ).thenAnswer((_) async => muscleGroupResponse);

        await vm.doIntent(SelectMuscleGroupEvent(muscleGroupId: '1', index: 0));

        expect(vm.state.exercises.first.name, 'Push Up');
        expect(vm.state.selectedMuscleGroupIndex, 0);
        expect(vm.state.isLoadingExercises, false);
      },
    );

    test('SelectMuscleGroupEvent error updates exercisesError', () async {
      when(mockMusclesGroupIdResponseUseCase.call(any)).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: 'fetch failed')),
      );

      await vm.doIntent(SelectMuscleGroupEvent(muscleGroupId: '1', index: 0));

      expect(vm.state.exercisesError, 'fetch failed');
      expect(vm.state.isLoadingExercises, false);
    });

    test('SelectMuscleGroupEvent uses cache if available', () async {
      when(
        mockMusclesGroupIdResponseUseCase.call(any),
      ).thenAnswer((_) async => muscleGroupResponse);

      await vm.doIntent(SelectMuscleGroupEvent(muscleGroupId: '1', index: 0));

      reset(mockMusclesGroupIdResponseUseCase);

      await vm.doIntent(SelectMuscleGroupEvent(muscleGroupId: '1', index: 0));

      verifyNever(mockMusclesGroupIdResponseUseCase.call(any));
      expect(vm.state.exercises.first.name, 'Push Up');
    });
  });
}
