import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class ProductShimmerCard extends StatelessWidget {
  final double? borderRadius;
  final double? aspectRatio;

  const ProductShimmerCard({super.key, this.borderRadius, this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.mdW(16),
        vertical: context.mdH(16),
      ),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: context.mdW(17),
        mainAxisSpacing: context.mdH(17),
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.grey[20]!,
          highlightColor: AppColors.grey[40]!,
          child: AspectRatio(
            aspectRatio: aspectRatio ?? 0.85,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.grey[20],
                borderRadius: BorderRadius.circular(
                  borderRadius ?? context.mdRadius(16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
