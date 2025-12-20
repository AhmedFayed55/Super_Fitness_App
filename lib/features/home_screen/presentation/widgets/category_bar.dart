import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/models_ui/category_ui_model.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({super.key});

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = context.height;
    var categories = CategoryModel.getCategory(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeletonizer(
            enabled: _isLoading,
            child: Text(
              context.localization.category,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          verticalSpace(screenHeight * 0.009),
          Skeletonizer(
            enabled: _isLoading,
            child: Container(
              height: screenHeight * 0.11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.grey[10],
              ),
              child: Row(
                children: [
                  for (int i = 0; i < categories.length; i++) ...[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.mdW(4),
                          vertical: context.mdH(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Image.asset(
                                categories[i].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: context.mdH(4)),
                            Flexible(
                              flex: 1,
                              child: Text(
                                categories[i].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
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
          ),
        ],
      ),
    );
  }
}
