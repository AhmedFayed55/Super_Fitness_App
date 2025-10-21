import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/onBoarding/domain/usecase/set_onboarding_as_seen_usecase.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/pages/onboarding_screen.dart';

class OnboardingButtons extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final Function(int) onPageChange;

  const OnboardingButtons({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var translations = context.localization;

    if (currentIndex == 0) {
      return SizedBox(
        width: double.infinity,
        height: height * 0.05,
        child: ElevatedButton(
          onPressed: () {
            if (currentIndex < images.length - 1) {
              onPageChange(currentIndex + 1);
              pageController.animateToPage(
                currentIndex + 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
              );
            }
          },
          child: Text(translations.next),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.18,
            height: height * 0.05,
            child: OutlinedButton(
              onPressed: () {
                if (currentIndex > 0) {
                  onPageChange(currentIndex - 1);
                  pageController.animateToPage(
                    currentIndex - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.colorScheme.primary),
              ),
              child: FittedBox(
                child: Text(
                  translations.back,
                  style: context.theme.textTheme.displaySmall,
                ),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.18,
            height: height * 0.05,
            child: ElevatedButton(
              onPressed: () async {
                if (currentIndex == 2) {
                  await getIt.get<SetOnboardingAsSeenUsecase>().invoke();
                  if (context.mounted) {
                    context.pushReplacementNamed(AppRoutes.login);
                  }
                } else {
                  onPageChange(currentIndex + 1);
                  pageController.animateToPage(
                    currentIndex + 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              child: FittedBox(
                child: Text(
                  currentIndex == 2 ? translations.got_it : translations.next,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
