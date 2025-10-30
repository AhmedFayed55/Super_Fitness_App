import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_event.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_view_model.dart';
import 'package:super_fitness_app/features/workouts/presentation/widgets/workouts_view.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutsViewModel>(
      create: (context) =>
          getIt.get<WorkoutsViewModel>()..doIntent(LoadMuscleGroupsEvent()),
      child: const WorkoutsView(),
    );
  }
}
