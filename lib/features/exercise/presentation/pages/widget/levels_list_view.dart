import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_event.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/level_widget.dart';

class LevelsListView extends StatefulWidget {
  const LevelsListView({super.key});

  @override
  State<LevelsListView> createState() => _LevelsListViewState();
}

class _LevelsListViewState extends State<LevelsListView> {
  String? _tempSelectedId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        final levels = state.data.difficulties;
        final selectedId = _tempSelectedId ?? state.data.selectedDifficultyId;

        if (levels.isEmpty) return const SizedBox.shrink();

        return Container(
          decoration: BoxDecoration(
            color: AppColors.cmykColor,
            borderRadius: BorderRadius.circular(context.mdRadius(30)),
          ),
          height: context.mdH(48),
          child: Center(
            child: SizedBox(
              height: context.mdH(30),
              child: levels.length == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: LevelWidget(
                            isSelected: true,
                            level: levels[0].name,
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mdW(16),
                      ),
                      itemCount: levels.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: context.mdW(60)),
                      itemBuilder: (context, index) {
                        final level = levels[index];
                        final isSelected = level.id == selectedId;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempSelectedId = level.id;
                            });

                            context.read<ExerciseCubit>().doIntent(
                              SwitchExerciseEvent(difficultyId: level.id),
                            );
                          },
                          child: LevelWidget(
                            level: level.name,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
