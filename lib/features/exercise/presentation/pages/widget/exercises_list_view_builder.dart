import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/blur_container.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercise_card.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/list_lodaing_shammer.dart';

class ExercisesListViewBuilder extends StatelessWidget {
  const ExercisesListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var exercises = context.watch<ExerciseCubit>().state.data.exercises;
    var translations = context.localization;
    return Expanded(
      child: CustomBlurContainer(
        child: BlocBuilder<ExerciseCubit, ExerciseState>(
          builder: (context, state) {
            if (state.loadingStatus.isExercisesLoading) {
              return const Center(
                child: ExerciseListShimmer(),
              );
            }
            if (state.errorMessage.exercisesErrorMessage != null) {
              return Center(
                child: Text(
                  state.errorMessage.exercisesErrorMessage!,
                  style: context.textTheme.bodyLarge,
                ),
              );
            }
            if (state.successStatus.isExercisesSuccess) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  var isLast = index == exercises.length - 1;
                  return Column(
                    children: [
                      verticalSpace(context.mdH(8)),
                      Padding(
                        padding: EdgeInsets.only(left: context.mdW(8) , right: context.mdW(8)),
                        child: ExerciseCard(exercise: exercises[index]),
                      ),
                      if (!isLast)
                        Divider(color: AppColors.grey[20], thickness: 1),
                    ],
                  );
                },
              );
            }
            if (state.data.exercises.isEmpty) {
              return Center(
                child: Text(
                  translations.no_exercises_available,
                  style: context.textTheme.bodyLarge,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: context.colorScheme.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
