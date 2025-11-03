import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/popular_training/presentation/manager/cubit/popular_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/loading_widget.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/popular_training_list_view_builder.dart';

class Popular extends StatelessWidget {
  Popular({super.key});

  final viewModel = getIt.get<PopularCubit>();

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => viewModel..getAllExercises(),

      child: SizedBox(
        height: context.mdH(177),
        child: BlocBuilder<PopularCubit, PopularState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const PopularTrainingShimmer();
            }
            if (state.errorMessage != null) {
              return Text(state.errorMessage!);
            }
            if (state.isSuccess && state.popularData == null) {
              return Center(child: Text(trans.there_is_no_exercises));
            }
            if (state.isSuccess && state.popularData != null) {
              var data = state.popularData!;
              return PopularTrainingListViewBuilder(data: data);
            }
            return Center(child: Text(trans.something_went_wrong));
          },
        ),
      ),
    );
  }
}
