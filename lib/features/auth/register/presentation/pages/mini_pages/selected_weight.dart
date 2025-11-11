import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_event.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_selected_number.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_bar_text.dart';

class SelectedWeight extends StatelessWidget {
  const SelectedWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        CustomBarText(
          text1: context.localization.what_is_your_weight,
          text2: context.localization.this_helps_your_plan,
        ),
        SelectNumber(
          label: context.localization.kg,
          value: context.watch<RegisterViewModel>().state.weight,
          min: 30,
          max: 200,
          onChanged: (value) {
            context.read<RegisterViewModel>().doIntent(SaveWeightEvent(value));
          },
          onPressed: () {
            context.read<RegisterViewModel>().pageController.nextPage(
              duration: const Duration(
                milliseconds: AppConstants.registerDuration,
              ),
              curve: Curves.easeInOut,
            );
          },
          buttonText: context.localization.next,
        ),
      ],
    );
  }
}
