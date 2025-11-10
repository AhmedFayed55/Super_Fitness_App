import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/usecase/get_all_exercises_by_difficulty_usecase.dart';
import 'package:super_fitness_app/features/exercise/domain/usecase/get_exercises_difficultes_by_muscle_usecase.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_event.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'exercise_state.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  final GetAllExercisesByDifficultyUsecase getAllExercisesByDifficultyUsecase;
  final GetExercisesDifficultesByMuscleUsecase
  getExercisesDifficultesByMuscleUsecase;

  ExerciseCubit(
    this.getAllExercisesByDifficultyUsecase,
    this.getExercisesDifficultesByMuscleUsecase,
  ) : super(ExerciseState.initial());

  YoutubePlayerController? _controller;
  YoutubePlayerController? get controller => _controller;

  Future<void> doIntent(ExerciseEvent event) {
    switch (event) {
      case GetExercisesDifficultiesEvent():
        return getExercisesDifficultiesByMuscle(event.muscleId);

      case SwitchExerciseEvent():
        return onDifficultyChanged(event.difficultyId);

      case GetExercisesByDifficultyEvent():
        return getExercisesByDifficulty(event.muscleId, event.difficultyId);
    }
  }

  Future<void> getExercisesDifficultiesByMuscle(String muscleId) async {
    emit(
      state.copyWith(
        loadingStatus: state.loadingStatus.copyWith(isScreenLoading: true),
        errorMessage: state.errorMessage.copyWith(screenErrorMessage: null),
      ),
    );

    final result = await getExercisesDifficultesByMuscleUsecase.invoke(
      muscleId,
    );

    switch (result) {
      case ApiErrorResult():
        emit(
          state.copyWith(
            loadingStatus: state.loadingStatus.copyWith(isScreenLoading: false),
            successStatus: state.successStatus.copyWith(isScreenSuccess: false),
            errorMessage: state.errorMessage.copyWith(
              screenErrorMessage: result.failure.errorMessage,
            ),
          ),
        );
        break;

      case ApiSuccessResult():
        final difficulties = result.data;

        if (difficulties.isEmpty) {
          emit(
            state.copyWith(
              loadingStatus: state.loadingStatus.copyWith(
                isScreenLoading: false,
              ),
              successStatus: state.successStatus.copyWith(
                isScreenSuccess: true,
              ),
              data: state.data.copyWith(
                difficulties: [],
                exercises: [],
                selectedDifficultyId: null,
              ),
            ),
          );
          return;
        }

        final firstDifficulty = difficulties.first;

        emit(
          state.copyWith(
            selectedMuscleId: muscleId,
            loadingStatus: state.loadingStatus.copyWith(isScreenLoading: false),
            successStatus: state.successStatus.copyWith(isScreenSuccess: true),
            data: state.data.copyWith(
              difficulties: difficulties,
              selectedDifficultyId: firstDifficulty.id,
            ),
          ),
        );

        await getExercisesByDifficulty(muscleId, firstDifficulty.id);
        break;
    }
  }

  Future<void> getExercisesByDifficulty(
    String muscleId,
    String difficultyId,
  ) async {
    emit(
      state.copyWith(
        loadingStatus: state.loadingStatus.copyWith(isExercisesLoading: true),
        errorMessage: state.errorMessage.copyWith(exercisesErrorMessage: null),
      ),
    );

    final result = await getAllExercisesByDifficultyUsecase.invoke(
      muscleId,
      difficultyId,
    );

    switch (result) {
      case ApiErrorResult():
        emit(
          state.copyWith(
            loadingStatus: state.loadingStatus.copyWith(
              isExercisesLoading: false,
            ),
            successStatus: state.successStatus.copyWith(
              isExercisesSuccess: false,
            ),
            errorMessage: state.errorMessage.copyWith(
              exercisesErrorMessage: result.failure.errorMessage,
            ),
          ),
        );
        break;

      case ApiSuccessResult():
        final exercises = result.data;

        YoutubePlayerController? newController;

        if (exercises.isNotEmpty &&
            exercises.first.shortYoutubeDemonstrationLink != null) {
          final videoId = YoutubePlayer.convertUrlToId(
            exercises.first.shortYoutubeDemonstrationLink ??
                "https://youtu.be/Ns1NS9ThNhI",
          );
          if (videoId != null) {
            newController = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                hideThumbnail: true,
                mute: true,
                autoPlay: true,
                loop: true,
                disableDragSeek: true,
                hideControls: true,
                enableCaption: false,
                useHybridComposition: true,
              ),
            );
          }
        }

        _controller = newController;

        emit(
          state.copyWith(
            loadingStatus: state.loadingStatus.copyWith(
              isExercisesLoading: false,
            ),
            successStatus: state.successStatus.copyWith(
              isExercisesSuccess: true,
            ),
            data: state.data.copyWith(
              exercises: exercises,
              selectedDifficultyId: difficultyId,
            ),
            videoController: _controller,
          ),
        );
        break;
    }
  }

  Future<void> onDifficultyChanged(String difficultyId) async {
    emit(
      state.copyWith(
        loadingStatus: state.loadingStatus.copyWith(isExercisesLoading: true),
        errorMessage: state.errorMessage.copyWith(exercisesErrorMessage: null),
      ),
    );
    final muscleId = state.selectedMuscleId;
    if (muscleId == null) return;

    var result = await getAllExercisesByDifficultyUsecase.invoke(
      muscleId,
      difficultyId,
    );
    switch (result) {
      case ApiErrorResult():
        emit(
          state.copyWith(
            loadingStatus: state.loadingStatus.copyWith(
              isExercisesLoading: false,
            ),
            successStatus: state.successStatus.copyWith(
              isExercisesSuccess: false,
            ),
            errorMessage: state.errorMessage.copyWith(
              exercisesErrorMessage: result.failure.errorMessage,
            ),
          ),
        );
        break;

      case ApiSuccessResult():
        final exercises = result.data;

        emit(
          state.copyWith(
            loadingStatus: state.loadingStatus.copyWith(
              isExercisesLoading: false,
            ),
            successStatus: state.successStatus.copyWith(
              isExercisesSuccess: true,
            ),
            data: state.data.copyWith(
              exercises: exercises,
              selectedDifficultyId: difficultyId,
            ),
          ),
        );
        break;
    }
  }

  void setPreloadedData(
    List<ExerciseEntity> exercises,
    List<DifficultyLevelEntity> difficulties,
  ) {
    YoutubePlayerController? newController;

    if (exercises.isNotEmpty &&
        exercises.first.shortYoutubeDemonstrationLink != null) {
      final videoId = YoutubePlayer.convertUrlToId(
        exercises.first.shortYoutubeDemonstrationLink ??
            "https://youtu.be/Ns1NS9ThNhI",
      );
      if (videoId != null) {
        newController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            hideThumbnail: true,
            mute: true,
            autoPlay: true,
            loop: true,
            disableDragSeek: true,
            hideControls: true,
            enableCaption: false,
            useHybridComposition: true,
          ),
        );
      }
    }

    _controller = newController;

    emit(
      state.copyWith(
        data: state.data.copyWith(
          exercises: exercises,
          difficulties: difficulties,
        ),
        videoController: _controller,
        successStatus: state.successStatus.copyWith(
          isScreenSuccess: true,
          isExercisesSuccess: true,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
