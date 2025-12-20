import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/widgets/custom_shimmer.dart';

/// Shimmer for Upcoming Workouts Tab
class UpcomingWorkoutsTabShimmer extends StatelessWidget {
  const UpcomingWorkoutsTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;

    return Column(
      children: [
        // Header shimmer (title and see all)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(
                width: screenWidth * 0.4,
                height: 22,
                radius: 8,
                color: AppColors.grey[30],
                highlightColor: AppColors.grey[20],
              ),
              ShimmerBox(
                width: screenWidth * 0.15,
                height: 16,
                radius: 8,
                color: AppColors.grey[30],
                highlightColor: AppColors.grey[20],
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        // Tab items shimmer
        SizedBox(
          height: screenHeight * 0.04,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ShimmerBox(
                width: screenWidth * 0.25,
                height: 45,
                radius: 20,
                color: AppColors.grey[30],
                highlightColor: AppColors.grey[20],
              );
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
      ],
    );
  }
}

/// Shimmer for Upcoming Workouts Items
class UpcomingWorkoutsItemsShimmer extends StatelessWidget {
  const UpcomingWorkoutsItemsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;

    return SizedBox(
      height: screenHeight * 0.1,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (context, index) {
          return SizedBox(width: screenWidth * 0.043);
        },
        itemBuilder: (context, index) {
          return ShimmerBox(
            width: screenHeight * 0.1,
            height: screenHeight * 0.1,
            radius: 20,
            color: AppColors.grey[30],
            highlightColor: AppColors.grey[20],
          );
        },
      ),
    );
  }
}

/// Shimmer for Recommendation Today
class RecommendationTodayShimmer extends StatelessWidget {
  const RecommendationTodayShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ShimmerBox(
            width: screenWidth * 0.5,
            height: 22,
            radius: 8,
            color: AppColors.grey[30],
            highlightColor: AppColors.grey[20],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        // Items shimmer
        SizedBox(
          height: screenWidth * 0.28,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) {
              return SizedBox(width: screenWidth * 0.043);
            },
            itemBuilder: (context, index) {
              return ShimmerBox(
                width: screenWidth * 0.28,
                height: screenWidth * 0.28,
                radius: 20,
                color: AppColors.grey[30],
                highlightColor: AppColors.grey[20],
              );
            },
          ),
        ),
      ],
    );
  }
}
