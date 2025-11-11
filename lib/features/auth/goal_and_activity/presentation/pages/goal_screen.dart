import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/widgets/goal_blocbuilder.dart';

class GoalScreen extends StatelessWidget {
  GoalScreen({super.key});

  final registerViewModel = getIt.get<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(screenHeight * 0.020),
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.043),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: context.localization.what_is_your_goal,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(
                  text: context
                      .localization
                      .this_helps_us_create_Your_personalized_plan,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(screenHeight * 0.020),
        const GoalBlocBuilder(),
      ],
    );
  }
}
