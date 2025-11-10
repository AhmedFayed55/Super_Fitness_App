import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/get_all_muscles_response_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/muscles_group_id_response_usecase.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_event.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_state.dart';

@injectable
class WorkoutsViewModel extends Cubit<WorkoutsState> {
  final GetAllMusclesResponseUseCase _getAllMusclesUseCase;
  final MusclesGroupIdResponseUseCase _musclesGroupIdUseCase;
  final Map<String, List<MusclesDtoEntity>> _cachedExercises = {};
  WorkoutsViewModel(this._getAllMusclesUseCase, this._musclesGroupIdUseCase)
    : super(const WorkoutsState());
  Future<void> doIntent(WorkoutsEvent event) async {
    switch (event) {
      case LoadMuscleGroupsEvent():
        await _loadMuscleGroups();
        break;

      case SelectMuscleGroupEvent():
        await _selectMuscleGroup(event.muscleGroupId, event.index);
        break;
    }
  }

  Future<void> _loadMuscleGroups() async {
    emit(state.copyWith(isLoadingGroups: true, error: null));
    final result = await _getAllMusclesUseCase.call();
    switch (result) {
      case ApiSuccessResult():
        final muscleGroups = result.data.musclesGroupDtoEntity;
        emit(
          state.copyWith(
            muscleGroups: muscleGroups,
            isLoadingGroups: false,
            error: null,
          ),
        );
        if (muscleGroups.isNotEmpty) {
          await _selectMuscleGroup(muscleGroups[0].id, 0);
        }
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoadingGroups: false,
            error: result.failure.errorMessage,
          ),
        );
        break;
    }
  }

  Future<void> _selectMuscleGroup(String muscleGroupId, int index) async {
    if (_cachedExercises.containsKey(muscleGroupId)) {
      emit(
        state.copyWith(
          selectedMuscleGroupIndex: index,
          exercises: _cachedExercises[muscleGroupId]!,
          isLoadingExercises: false,
          exercisesError: null,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        selectedMuscleGroupIndex: index,
        isLoadingExercises: true,
        exercisesError: null,
        exercises: [],
      ),
    );

    final result = await _musclesGroupIdUseCase.call(muscleGroupId);
    switch (result) {
      case ApiSuccessResult():
        final exercises = result.data.musclesDtoEntity;
        _cachedExercises[muscleGroupId] = exercises;
        emit(
          state.copyWith(
            selectedMuscleGroup: result.data.muscleGroupDtoEntity,
            exercises: result.data.musclesDtoEntity,
            isLoadingExercises: false,
            exercisesError: null,
          ),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoadingExercises: false,
            exercisesError: result.failure.errorMessage,
          ),
        );
        break;
    }
  }
}
