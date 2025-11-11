import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class ChatWelcomeShimmer extends StatelessWidget {
  const ChatWelcomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    // Darker shimmer colors for visibility
    final base = AppColors.grey[60] ?? Colors.grey.shade300;
    final highlight = AppColors.grey[20] ?? Colors.grey.shade100;

    return Scaffold(
      backgroundColor: AppColors.grey[10] ?? Colors.grey.shade50,
      body: Shimmer.fromColors(
        baseColor: base,
        highlightColor: highlight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.mdW(20),
            vertical: context.mdH(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.mdH(20)),
              Column(
                children: [
                  _shimmerBox(context, w: 140, h: 20),
                  SizedBox(height: context.mdH(8)),
                  _shimmerBox(context, w: 180, h: 18),
                ],
              ),
              SizedBox(height: context.mdH(20)),

              Expanded(
                child: Center(
                  child: _shimmerBox(context, w: 280, h: 280, radius: 24),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: context.mdW(16)),
                padding: EdgeInsets.all(context.mdW(24)),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: base.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(context.mdRadius(28)),
                ),
                child: Column(
                  children: [
                    _shimmerBox(context, w: 220, h: 18),
                    SizedBox(height: context.mdH(10)),
                    _shimmerBox(context, w: 140, h: 18),
                    SizedBox(height: context.mdH(40)),
                    _shimmerBox(
                      context,
                      w: double.infinity,
                      h: 48,
                      radius: 16,
                      // ignore: deprecated_member_use
                      color: colorScheme.primary.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.mdH(24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shimmerBox(
    BuildContext context, {
    required double w,
    required double h,
    double? radius,
    Color? color,
  }) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color ?? AppColors.grey[60] ?? Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius ?? context.mdRadius(12)),
      ),
    );
  }
}
