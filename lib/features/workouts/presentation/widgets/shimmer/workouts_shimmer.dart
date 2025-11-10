import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class WorkoutsShimmer extends StatelessWidget {
  const WorkoutsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey[20]!,
      highlightColor: AppColors.grey[40]!,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.mdW(16),
          vertical: context.mdH(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: context.mdW(120),
              height: context.mdH(24),
              decoration: BoxDecoration(
                color: AppColors.grey[20],
                borderRadius: BorderRadius.circular(context.mdRadius(25)),
              ),
            ),
            SizedBox(height: context.mdH(24)),
            SizedBox(
              height: context.mdH(40),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => SizedBox(width: context.mdW(8)),
                itemBuilder: (context, index) => Container(
                  width: context.mdW(90),
                  height: context.mdH(40),
                  decoration: BoxDecoration(
                    color: AppColors.grey[20],
                    borderRadius: BorderRadius.circular(context.mdRadius(25)),
                  ),
                ),
              ),
            ),
            SizedBox(height: context.mdH(24)),

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
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey[20],
                    borderRadius: BorderRadius.circular(context.mdRadius(16)),
                  ),
                ),
              ),
            ),

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
      ),
    );
  }
}
