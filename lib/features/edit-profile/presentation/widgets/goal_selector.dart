// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';

class GoalSelector extends StatelessWidget {
  final List<String> goals;
  final String selectedGoal;
  final ValueChanged<String> onSelect;
  final VoidCallback onNext;

  const GoalSelector({
    super.key,
    required this.goals,
    required this.selectedGoal,
    required this.onSelect,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
    var trans = context.localization;

    return Column(
      children: [
        ListView.separated(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03,
            horizontal: screenWidth * 0.043,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final goal = goals[index];
            return Container(
              width: screenWidth * 0.83,
              height: screenHeight * 0.044,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.white),
                borderRadius: BorderRadius.circular(20),
                color: context.colorScheme.onPrimary.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      goal,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: AppColors.white),
                    ),
                  ),
                  Radio<String>(
                    value: goal,
                    groupValue: selectedGoal,
                    activeColor: context.colorScheme.primary,
                    onChanged: (val) {
                      if (val != null) onSelect(val);
                    },
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => verticalSpace(screenHeight * 0.02),
          itemCount: goals.length,
        ),

        CustomElevatedButton(
          onPressed: onNext,
          isLoading: false,
          widget: Text(trans.done),
        ),
      ],
    );
  }
}
