import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/explore/presentation/page/explore_page.dart';
import 'package:super_fitness_app/features/profile/presentation/page/profile_page.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/pages/chat_screen.dart';
import 'package:super_fitness_app/features/workouts/presentation/pages/workouts_screen.dart';

class AppSections extends StatefulWidget {
  const AppSections({super.key});

  @override
  State<AppSections> createState() => _AppSectionsState();
}

class _AppSectionsState extends State<AppSections> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final List<Widget> pages = [
      const ExplorePage(),
      const ChatScreen(),
      const WorkoutsScreen(),
      const ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: context.width * 0.08,
          right: context.width * 0.08,
          bottom: context.height * 0.024,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.width * 0.06),
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  height: context.height * 0.08,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.black.withValues(alpha: 0.15),
                        AppColors.black.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.10),
                        AppColors.black.withValues(alpha: 0.15),
                        AppColors.black.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.10),
                        AppColors.black.withValues(alpha: 0.15),
                        AppColors.black.withValues(alpha: 0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(context.width * 0.06),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                      width: context.width * 0.003,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: context.width * 0.05,
                        offset: Offset(0, context.height * 0.007),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: _buildBottomNavigationBarItem(
                      AppAssets.homeIcon,
                      localization.explore,
                      0,
                    ),
                  ),
                  Flexible(
                    child: _buildBottomNavigationBarItem(
                      AppAssets.chatBotIcon,
                      localization.chatbot,
                      1,
                    ),
                  ),
                  Flexible(
                    child: _buildBottomNavigationBarItem(
                      AppAssets.workoutIcon,
                      localization.workout,
                      2,
                    ),
                  ),
                  Flexible(
                    child: _buildBottomNavigationBarItem(
                      AppAssets.profileIcon,
                      localization.profile,
                      3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: pages[_currentIndex],
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(String icon, String label, int index) {
    final bool selected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: selected ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            child: SvgPicture.asset(
              icon,
              width: context.width * 0.06,
              height: context.width * 0.06,
              colorFilter: ColorFilter.mode(
                selected
                    ? context.colorScheme.primary
                    : Colors.white.withValues(alpha: 0.85),
                BlendMode.srcIn,
              ),
            ),
          ),
          if (selected) ...[
            verticalSpace(context.height * 0.004),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                label,
                key: ValueKey(label),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: context.colorScheme.primary,
                  fontSize: context.width * 0.033,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
