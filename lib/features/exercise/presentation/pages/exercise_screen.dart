import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_event.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercise_body.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/shammer_loading.dart';

class ExerciseScreen extends StatelessWidget {
  final ExerciseScreenMode mode;
  final String? muscleId;
  final List<ExerciseEntity>? exercises;
  final List<DifficultyLevelEntity>? difficulties;

  ExerciseScreen.byMuscleId({super.key, required this.muscleId})
    : mode = ExerciseScreenMode.byMuscleId,
      exercises = null,
      difficulties = null;

  ExerciseScreen.byPreloadedData({
    super.key,
    required this.exercises,
    required this.difficulties,
  }) : mode = ExerciseScreenMode.byPreloadedData,
       muscleId = null;

  final ExerciseCubit viewModel = getIt.get<ExerciseCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = viewModel;
        if (mode == ExerciseScreenMode.byMuscleId && muscleId != null) {
          cubit.doIntent(GetExercisesDifficultiesEvent(muscleId: muscleId!));
        } else if (mode == ExerciseScreenMode.byPreloadedData &&
            exercises != null &&
            difficulties != null) {
          cubit.setPreloadedData(exercises!, difficulties!);
        }
        return cubit;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              margin: EdgeInsets.only(left: context.mdW(16)),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  height: context.mdH(10),
                  AppAssets.arrowBack,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.exerciseScreenBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<ExerciseCubit, ExerciseState>(
            builder: (context, state) {
              if (state.loadingStatus.isScreenLoading) {
                return const ExerciseShimmerScreen();
              }
              if (state.errorMessage.screenErrorMessage != null) {
                return Center(
                  child: Text(
                    state.errorMessage.screenErrorMessage!,
                    style: context.textTheme.bodyLarge,
                  ),
                );
              }
              if (state.successStatus.isScreenSuccess &&
                  state.data.difficulties.isNotEmpty) {
                return const ExerciseBody();
              }
              return const ExerciseShimmerScreen();
            },
          ),
        ),
      ),
    );
  }
}
