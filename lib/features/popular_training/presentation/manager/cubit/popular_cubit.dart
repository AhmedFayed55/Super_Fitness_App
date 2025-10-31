import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/use_case/get_all_exercises_use_case.dart';

part 'popular_state.dart';

@injectable
class PopularCubit extends Cubit<PopularState> {
  GetAllExercisesUseCase getAllExercisesUseCase;
  PopularCubit(this.getAllExercisesUseCase) : super(const PopularState());

  Future<void> getAllExercises() async {
    emit(state.copyWith(isLoading: true));

    var response = await getAllExercisesUseCase.invoke(
      const GetAllExercisesRequestEntity(page: 1, limit: 50),
    );

    switch (response) {
      case ApiSuccessResult():
        var data = _filterExercisesByLevel(response.data);
        log(data.first.level.toString());
        log(data.first.exercises!.first.exercise.toString());
        emit(
          state.copyWith(isLoading: false, isSuccess: true, popularData: data),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            errorMessage: response.failure.errorMessage,
          ),
        );
        break;
    }
  }

  List<PopularData> _filterExercisesByLevel(
    GetAllExercisesResponseEntity respone,
  ) {
    final List<ExerciseEntity> allExercises = respone.exercises;
    final Map<String, List<ExerciseEntity>> groupedByLevelString = {};

    for (final exercise in allExercises) {
      final levelString = exercise.difficultyLevel;

      groupedByLevelString.putIfAbsent(levelString, () => []);

      groupedByLevelString[levelString]!.add(exercise);
    }

    final List<PopularData> popularDataList = [];

    groupedByLevelString.forEach((levelString, exercisesInLevel) {
      final Level currentLevel = Level.beginner.getLevelEn(levelString);

      final popularData = PopularData(
        exercises: exercisesInLevel,
        level: currentLevel,
      );

      popularDataList.add(popularData);
    });

    return popularDataList;
  }
}
