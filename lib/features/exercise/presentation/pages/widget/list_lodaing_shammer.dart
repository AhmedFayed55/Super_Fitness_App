import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';

class ExerciseListShimmer extends StatelessWidget {
  const ExerciseListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.3), 
      highlightColor: Colors.white.withValues(alpha:0.5),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: context.mdW(16),
          vertical: context.mdH(8),
        ),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.mdH(88),
                width: context.mdW(81),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(context.mdRadius(20)),
                ),
              ),
              horizontalSpace(context.mdW(17)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: context.mdH(16),
                      width: context.mdW(150),
                      color: Colors.grey.shade300,
                    ),
                    verticalSpace(context.mdH(8)),
                    Container(
                      height: context.mdH(12),
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                    verticalSpace(context.mdH(6)),
                    Container(
                      height: context.mdH(12),
                      width: context.mdW(120),
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),

              horizontalSpace(context.mdW(10)),
              Container(
                height: context.mdW(32),
                width: context.mdW(32),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => verticalSpace(context.mdH(16)),
        itemCount: 5, 
      ),
    );
  }
}
