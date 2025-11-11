import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_event.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';

class GoalBlocBuilder extends StatelessWidget {
  const GoalBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegisterViewModel>();
    final List<String> goals = [
      context.localization.gain_weight,
      context.localization.lose_weight,
      context.localization.get_fitter,
      context.localization.gain_more_flexible,
      context.localization.learn_the_basic,
    ];
    var screenWidth = context.width;
    var screenHeight = context.height;
    return BlocBuilder<RegisterViewModel, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            bottom: screenHeight * 0.030,
            right: screenWidth * 0.043,
            left: screenWidth * 0.043,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff242424).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: [
              ListView.separated(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.030,
                  left: screenWidth * 0.043,
                  right: screenWidth * 0.043,
                  bottom: screenHeight * 0.030,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth * 0.83,
                    height: screenHeight * 0.044,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.white),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.043,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          goals[index],
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.white),
                        ),
                        RadioGroup(
                          groupValue: state.goalSelected,
                          onChanged: (value) {
                            cubit.doIntent(OnSelectedGoalEvent(goal: value));
                          },
                          child: Radio(
                            value: goals[index],
                            side: const BorderSide(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(screenHeight * 0.020);
                },
                itemCount: goals.length,
              ),
              CustomElevatedButton(
                onPressed: state.goalSelected != null
                    ? () {
                        /// Button OnPressed
                        context
                            .read<RegisterViewModel>()
                            .pageController
                            .nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.bounceIn,
                            );
                      }
                    : null,
                isLoading: false,
                widget: Text(context.localization.next),
              ),
            ],
          ),
        );
      },
    );
  }
}
