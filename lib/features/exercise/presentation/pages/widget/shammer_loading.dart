import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';

class ExerciseShimmerScreen extends StatelessWidget {
  const ExerciseShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Shimmer.fromColors(
        baseColor: Colors.white.withValues(alpha: 0.5),
        highlightColor: Colors.white.withValues(alpha: 0.7),
        child: Column(
          children: [
            Container(
              height: context.mdH(300),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(context.mdRadius(16)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.mdW(16),
                  vertical: context.mdH(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.mdH(40),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            6,
                            (_) => Padding(
                              padding: EdgeInsets.only(right: context.mdW(10)),
                              child: Container(
                                height: context.mdH(35),
                                width: context.mdW(90),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(
                                    context.mdRadius(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(context.mdH(16)),

                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: 4,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: context.mdH(16)),
                        itemBuilder: (context, index) => Row(
                          children: [
                            Container(
                              height: context.mdH(80),
                              width: context.mdW(90),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(
                                  context.mdRadius(16),
                                ),
                              ),
                            ),
                            SizedBox(width: context.mdW(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: context.mdH(16),
                                    width: context.mdW(100),
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                                  SizedBox(height: context.mdH(8)),
                                  Container(
                                    height: context.mdH(14),
                                    width: context.mdW(160),
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                                  SizedBox(height: context.mdH(6)),
                                  Container(
                                    height: context.mdH(14),
                                    width: context.mdW(120),
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: context.mdW(8)),
                            Container(
                              height: context.mdW(32),
                              width: context.mdW(32),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
