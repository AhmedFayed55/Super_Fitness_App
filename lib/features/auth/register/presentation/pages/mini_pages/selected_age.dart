import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_event.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_selected_number.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_bar_text.dart';

class SelectedAge extends StatelessWidget {
  const SelectedAge({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBarText(
          key1: const Key(AppKeys.selectedAgeTitle),
          key2: const Key(AppKeys.selectedAgeSubtitle),
          text1: locale.how_old_are_you,
          text2: locale.this_helps_your_plan,
        ),
        SelectNumber(
          label: locale.year,
          value: context.watch<RegisterViewModel>().state.age,
          min: AppConstants.minAge,
          max: AppConstants.maxAge,
          onChanged: (value) {
            context.read<RegisterViewModel>().doIntent(SaveAgeEvent(value));
          },
          onPressed: () {
            context.read<RegisterViewModel>().pageController.nextPage(
              duration: const Duration(
                milliseconds: AppConstants.registerDuration,
              ),
              curve: Curves.easeInOut,
            );
          },
          buttonText: locale.next,
          key: const Key(AppKeys.selectedAgeButton),
        ),
      ],
    );
  }
}
