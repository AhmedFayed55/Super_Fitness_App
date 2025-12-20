import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/widgets/custom_shimmer.dart';

class WorkoutsShimmer extends StatelessWidget {
  const WorkoutsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.mdW(16),
        vertical: context.mdH(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title shimmer
          CustomShimmer(
            child: Container(
              width: context.mdW(120),
              height: context.mdH(24),
              decoration: BoxDecoration(
                color: AppColors.grey[20],
                borderRadius: BorderRadius.circular(context.mdRadius(25)),
              ),
            ),
          ),

          SizedBox(height: context.mdH(24)),

          // Category tabs shimmer
          SizedBox(
            height: context.mdH(40),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(width: context.mdW(8)),
              itemBuilder: (context, index) => CustomShimmer(
                child: Container(
                  width: context.mdW(90),
                  height: context.mdH(40),
                  decoration: BoxDecoration(
                    color: AppColors.grey[20],
                    borderRadius: BorderRadius.circular(context.mdRadius(25)),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: context.mdH(24)),

          // Workouts grid shimmer
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: context.mdW(17),
                mainAxisSpacing: context.mdH(17),
              ),
              itemCount: 6,
              itemBuilder: (context, index) => CustomShimmer(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey[20],
                    borderRadius: BorderRadius.circular(context.mdRadius(16)),
                  ),
                ),
              ),
            ),
          ),

          // Loading text
          Padding(
            padding: EdgeInsets.only(top: context.mdH(16)),
            child: Text(
              context.localization.workouts_loading,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
