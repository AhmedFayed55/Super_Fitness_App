import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/background_video.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercises_list_view_builder.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/levels_list_view.dart';

class ExerciseBody extends StatefulWidget {
  const ExerciseBody({super.key});

  @override
  State<ExerciseBody> createState() => _ExerciseBodyState();
}

class _ExerciseBodyState extends State<ExerciseBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BackgroundVideo(),
        const LevelsListView(),
        verticalSpace(context.mdH(8)),
        const ExercisesListViewBuilder(),
      ],
    );
  }
}
