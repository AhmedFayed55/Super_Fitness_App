import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/pages/activity_screen.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/pages/goal_screen.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/mini_pages/selected_gender.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/mini_pages/selected_age.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/mini_pages/selected_hight.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/mini_pages/selected_weight.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_arrow_back.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_main_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedGender;
  late final RegisterViewModel cubit;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    cubit = getIt<RegisterViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var color = context.colorScheme;

    return BlocProvider.value(
      value: cubit,

      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  AppAssets.bgImagePng,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * .06,
                        left: width * .03,
                        right: width * .03,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(AppAssets.logoImage, width: width * 0.35),

                          if (_currentPage > 0) ...[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: BackArrowButton(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (_currentPage > 0) ...[
                      verticalSpace(height * .07),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularPercentIndicator(
                          backgroundColor: Colors.transparent,
                          radius: 20.0,
                          lineWidth: width * .01,
                          percent: (_currentPage) / 6,
                          center: Text('$_currentPage/ 6'),
                          progressColor: color.primary,
                        ),
                      ),
                      verticalSpace(height * .03),
                    ],
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        controller: context
                            .read<RegisterViewModel>()
                            .pageController,
                        children: [
                          const CustomMainRegister(),
                          const SelectedGender(),
                          const SelectedAge(),
                          const SelectedWeight(),
                          const SelectedHight(),
                          GoalScreen(),
                          ActivityScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
