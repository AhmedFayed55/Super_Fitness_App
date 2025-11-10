import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController controller;
  final List<String> images;

  const OnboardingPageView({
    super.key,
    required this.controller,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    final size6Height = height * 0.06;
    final size65Height = height * 0.65;

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: images.length,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    verticalSpace(size6Height),
                    SizedBox(
                      height: size65Height,
                      child: FittedBox(child: Image.asset(images[index])),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
