import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/models_ui/category_ui_model.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = context.height;
    var categories = CategoryModel.getCategory(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localization.category,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          verticalSpace(screenHeight * 0.009),
          Container(
            height: screenHeight * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.grey[10],
            ),
            child: Row(
              children: [
                for (int i = 0; i < categories.length; i++) ...[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(categories[i].image),
                        Text(categories[i].name),
                      ],
                    ),
                  ),
                  if (i != categories.length - 1)
                    VerticalDivider(
                      color: AppColors.grey[20],
                      indent: screenHeight * 0.01,
                      endIndent: screenHeight * 0.01,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
