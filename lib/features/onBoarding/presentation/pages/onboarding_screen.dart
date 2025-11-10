import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/onBoarding/domain/usecase/set_onboarding_as_seen_usecase.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_background.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_bottom_section.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/widgets/onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var translations = context.localization;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          currentIndex != 2
              ? TextButton(
                  onPressed: () {
                    getIt.get<SetOnboardingAsSeenUsecase>().invoke();
                    context.pushReplacementNamed(AppRoutes.login);
                  },
                  child: Text(
                    translations.skip,
                    style: context.theme.textTheme.displayMedium,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: Stack(
        children: [
          const OnboardingBackground(),
          OnboardingPageView(controller: pageController, images: images),
          OnboardingBottomSection(
            pageController: pageController,
            currentIndex: currentIndex,
            onPageChange: (index) {
              setState(() => currentIndex = index);
            },
          ),
        ],
      ),
    );
  }
}

List<String> images = [
  AppAssets.onboarding1,
  AppAssets.onboarding2,
  AppAssets.onboarding3,
];
