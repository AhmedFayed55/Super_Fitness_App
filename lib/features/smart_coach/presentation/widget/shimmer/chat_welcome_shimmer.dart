import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/widgets/custom_shimmer.dart';

class ChatWelcomeShimmer extends StatelessWidget {
  const ChatWelcomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final baseColor = AppColors.grey[60] ?? Colors.grey.shade700;

    return Scaffold(
      backgroundColor: AppColors.grey[10] ?? Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header area with menu and title
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerBox(
                    width: size.width * 0.08,
                    height: size.width * 0.08,
                    radius: 8,
                    color: baseColor,
                  ),
                  Column(
                    children: [
                      ShimmerBox(
                        width: size.width * 0.4,
                        height: size.height * 0.02,
                        radius: 8,
                        color: baseColor,
                      ),
                      SizedBox(height: size.height * 0.008),
                      ShimmerBox(
                        width: size.width * 0.5,
                        height: size.height * 0.018,
                        radius: 8,
                        color: baseColor,
                      ),
                    ],
                  ),
                  SizedBox(width: size.width * 0.08),
                ],
              ),

              SizedBox(height: size.height * 0.04),

              // Robot image placeholder
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShimmerBox(
                        width: size.width * 0.6,
                        height: size.width * 0.6,
                        radius: size.width * 0.05,
                        color: baseColor,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // Bottom welcome message and button area
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: size.width * 0.9),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.025,
                ),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: baseColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(size.width * 0.06),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Welcome message lines
                    ShimmerBox(
                      width: size.width * 0.6,
                      height: size.height * 0.02,
                      radius: 6,
                      color: baseColor,
                    ),
                    SizedBox(height: size.height * 0.01),
                    ShimmerBox(
                      width: size.width * 0.4,
                      height: size.height * 0.018,
                      radius: 6,
                      color: baseColor,
                    ),

                    SizedBox(height: size.height * 0.03),

                    // Get started button
                    ShimmerBox(
                      width: double.infinity,
                      height: size.height * 0.06,
                      radius: size.width * 0.04,
                      // ignore: deprecated_member_use
                      color: colorScheme.primary.withOpacity(0.3),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
