import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_buttons.dart';

class OnboardingBottomSection extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final Function(int) onPageChange;

  const OnboardingBottomSection({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(height * 0.05),
            topRight: Radius.circular(height * 0.05),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(height * 0.05),
            topRight: Radius.circular(height * 0.05),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.white.withValues(alpha: 0.05),
              padding: EdgeInsets.symmetric(
                vertical: height * 0.03,
                horizontal: width * 0.05,
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        titles[currentIndex],
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.displayLarge,
                      ),
                      verticalSpace(height * 0.012),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Eu urna\nut gravida quis id pretium purus. Mauris massa ',
                        style: context.theme.textTheme.displaySmall!.copyWith(
                          color: AppColors.grey[90],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(height * 0.03),
                      AnimatedSmoothIndicator(
                        onDotClicked: (index) {
                          onPageChange(index);
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        activeIndex: currentIndex,
                        count: 3,
                        effect: WormEffect(
                          dotHeight: height * 0.01,
                          dotWidth: height * 0.01,
                          activeDotColor: context.colorScheme.primary,
                          dotColor: context.colorScheme.onPrimary,
                        ),
                      ),
                      verticalSpace(height * 0.03),
                      OnboardingButtons(
                        currentIndex: currentIndex,
                        pageController: pageController,
                        onPageChange: onPageChange,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> titles = [
  'the price of excellence\n is discipline',
  'Fitness has never been so \n much fun',
  'NO MORE EXCUSES \n Do It Now',
];
