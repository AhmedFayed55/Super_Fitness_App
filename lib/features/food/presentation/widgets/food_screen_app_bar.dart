import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';

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
        Expanded(
          child: Text(
            context.localization.food_recommendation,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.displayLarge!.copyWith(
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ),
        SizedBox(width: context.width * 0.1),
      ],
    );
  }
}
