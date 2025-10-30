import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/font_weight.dart';

class FoodScreenAppBar extends StatelessWidget {
  const FoodScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(AppAssets.arrowBackIcon),
          ),
        ),
        Text(
          context.localization.food_recommendation,
          style: context.textTheme.displayLarge!.copyWith(
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        const SizedBox.shrink(),
      ],
    );
  }
}
