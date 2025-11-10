// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';

class ActivitySelector extends StatelessWidget {
  final List<String> activities;
  final String selectedActivity;
  final ValueChanged<String> onSelect;
  final VoidCallback onNext;

  const ActivitySelector({
    super.key,
    required this.activities,
    required this.selectedActivity,
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
            vertical: screenHeight * 0.030,
            horizontal: screenWidth * 0.043,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = activities[index];
            return Container(
              width: screenWidth * 0.83,
              height: screenHeight * 0.044,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.white),
                borderRadius: BorderRadius.circular(20),
                color: context.colorScheme.onPrimary.withValues(alpha: 0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      item,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: AppColors.white),
                    ),
                  ),
                  Radio<String>(
                    value: item,
                    groupValue: selectedActivity,
                    activeColor: context.colorScheme.primary,
                    onChanged: (val) {
                      if (val != null) onSelect(val);
                    },
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => verticalSpace(screenHeight * 0.020),
          itemCount: activities.length,
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
