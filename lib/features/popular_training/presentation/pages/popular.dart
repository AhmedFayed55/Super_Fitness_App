import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/popular_training/presentation/manager/cubit/popular_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/popular_training_list_view_builder.dart';

class Popular extends StatelessWidget {
  Popular({super.key});

  final viewModel = getIt.get<PopularCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel..getAllExercises(),

      child: SizedBox(
        height: context.mdH(177),
        child: BlocBuilder<PopularCubit, PopularState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
              );
            }
            if (state.errorMessage != null) {
              return Text(state.errorMessage!);
            }
            if (state.isSuccess && state.popularData == null) {
              return const Text('No data');
            }
            if (state.isSuccess && state.popularData != null) {
              var data = state.popularData!;
              return PopularTrainingListViewBuilder(data: data);
            }
            return const Text("something went wrong");
          },
        ),
      ),
    );
  }
}
