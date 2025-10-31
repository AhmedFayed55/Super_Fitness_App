import 'dart:math';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${context.localization.hi} UserName ,\n",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text: context.localization.lets_start_your_day,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: min(screenWidth, screenHeight) * 0.1,
          backgroundColor: AppColors.lightOrange[30],
        ),
      ],
    );
  }
}
