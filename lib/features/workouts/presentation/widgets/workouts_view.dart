import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_event.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_state.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_view_model.dart';
import 'package:super_fitness_app/features/workouts/presentation/widgets/exercise_card.dart';
import 'package:super_fitness_app/features/workouts/presentation/widgets/muscle_group_tab.dart';
import 'package:super_fitness_app/widgets/product_shimmer_card.dart';
import 'package:super_fitness_app/features/workouts/presentation/widgets/shimmer/workouts_shimmer.dart';

class WorkoutsView extends StatelessWidget {
  const WorkoutsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final tr = context.localization;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.workoutBg, fit: BoxFit.cover),
          ).blurred(blur: 5, colorOpacity: 0.01),

          SafeArea(
            child: BlocConsumer<WorkoutsViewModel, WorkoutsState>(
              listenWhen: (prev, curr) =>
                  prev.error != curr.error ||
                  prev.exercisesError != curr.exercisesError,
              listener: (context, state) {
                if (state.error != null && state.error!.isNotEmpty) {
                  DialogueUtils.showMessage(
                    context: context,
                    message: state.error!,
                    title: tr.error,
                    posActionName: tr.ok,
                  );
                }

                if (state.exercisesError != null &&
                    state.exercisesError!.isNotEmpty) {
                  DialogueUtils.showMessage(
                    context: context,
                    message: state.exercisesError!,
                    title: tr.error,
                    posActionName: tr.ok,
                  );
                }
              },
              builder: (context, state) {
                if (state.isLoadingGroups) {
                  return const Expanded(child: WorkoutsShimmer());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.localization.workouts_title,
                      style: theme.textTheme.displayLarge,
                    ),
                    SizedBox(height: context.mdH(24)),
                    BlocBuilder<WorkoutsViewModel, WorkoutsState>(
                      buildWhen: (prev, curr) =>
                          prev.isLoadingGroups != curr.isLoadingGroups ||
                          prev.muscleGroups != curr.muscleGroups ||
                          prev.selectedMuscleGroupIndex !=
                              curr.selectedMuscleGroupIndex,
                      builder: (context, state) {
                        return SizedBox(
                          height: context.mdH(45),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: context.mdW(16),
                            ),
                            itemCount: state.muscleGroups.length,
                            itemBuilder: (context, index) {
                              final group = state.muscleGroups[index];
                              final isSelected =
                                  state.selectedMuscleGroupIndex == index;

                              return MuscleGroupTab(
                                label: group.name,
                                isSelected: isSelected,
                                onTap: () {
                                  context.read<WorkoutsViewModel>().doIntent(
                                    SelectMuscleGroupEvent(
                                      muscleGroupId: group.id,
                                      index: index,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: context.mdH(24)),

                    Expanded(
                      child: BlocBuilder<WorkoutsViewModel, WorkoutsState>(
                        buildWhen: (prev, curr) =>
                            prev.isLoadingExercises !=
                                curr.isLoadingExercises ||
                            prev.exercises != curr.exercises,
                        builder: (context, state) {
                          if (state.isLoadingExercises) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: context.mdH(16)),
                              child: const ProductShimmerCard(),
                            );
                          }

                          if (state.exercises.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.fitness_center_rounded,
                                    size: context.mdIcon(64),
                                    color: theme.colorScheme.primary,
                                  ),
                                  SizedBox(height: context.mdH(12)),
                                  Text(
                                    context.localization.workouts_no_exercises,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.mdW(16),
                              vertical: context.mdH(16),
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.85,
                                  crossAxisSpacing: context.mdW(17),
                                  mainAxisSpacing: context.mdH(17),
                                ),
                            itemCount: state.exercises.length,
                            itemBuilder: (context, index) {
                              final exercise = state.exercises[index];
                              return ExerciseCard(
                                exercise: exercise,
                                onTap: () {
                                  context.pushNamed(
                                    AppRoutes.exercise,
                                    arguments: exercise.id,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
