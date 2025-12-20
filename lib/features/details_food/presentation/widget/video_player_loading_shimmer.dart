import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/widgets/custom_shimmer.dart';

class VideoPlayerLoadingShimmer extends StatelessWidget {
  const VideoPlayerLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.mdH(330),
      width: double.infinity,
      child: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.cmyKColor,
                  AppColors.cmyKColor.withValues(alpha: 0.8),
                  AppColors.cmyKColor.withValues(alpha: 0.5),
                  AppColors.cmyKColor.withValues(alpha: 0.3),
                ],
              ),
            ),
          ),
          // Shimmer content
          CustomShimmer(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mdW(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // اسم الأكلة (العنوان)
                  Container(
                    height: context.mdH(24),
                    width: context.mdW(200),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  verticalSpace(context.mdH(8)),

                  // الوصف
                  Container(
                    height: context.mdH(16),
                    width: context.mdW(280),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  verticalSpace(context.mdH(5)),
                  Container(
                    height: context.mdH(16),
                    width: context.mdW(240),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  verticalSpace(context.mdH(24)),

                  // الدايرة بتاعة العناصر (Energy, Protein,...)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => Container(
                        height: context.mdH(55),
                        width: context.mdW(55),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(context.mdH(8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
