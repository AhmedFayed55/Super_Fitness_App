import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';

class VideoPlayerLoadingShimmer extends StatelessWidget {
  const VideoPlayerLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.mdH(330),
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: AppColors.grey,
        highlightColor: Colors.white,
        child: Container(
          color: AppColors.cmyKColor,
          padding: EdgeInsets.symmetric(horizontal: context.mdW(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // اسم الأكلة (العنوان)
              Container(
                height: context.mdH(20),
                width: context.mdW(180),
                color: Colors.white,
              ),
              verticalSpace(context.mdH(8)),

              // الوصف
              Container(
                height: context.mdH(14),
                width: context.mdW(260),
                color: Colors.white,
              ),
              verticalSpace(context.mdH(5)),
              Container(
                height: context.mdH(14),
                width: context.mdW(220),
                color: Colors.white,
              ),

              verticalSpace(context.mdH(20)),

              // الدايرة بتاعة العناصر (Energy, Protein,...)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => Container(
                    height: context.mdH(50),
                    width: context.mdW(50),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              verticalSpace(context.mdH(8)),
            ],
          ),
        ),
      ),
    );
  }
}
