import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/enum.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_event.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_blur_page_view.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_gender_option.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_bar_text.dart';

class SelectedGender extends StatefulWidget {
  const SelectedGender({super.key});

  @override
  State<SelectedGender> createState() => _SelectedGenderState();
}

class _SelectedGenderState extends State<SelectedGender> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var locale = context.localization;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBarText(
          text1: locale.tell_us_about_yourself,
          text2: locale.we_need_to_know_your_gender,
        ),
        CustomBlurPageView(
          child: Padding(
            padding: EdgeInsets.all(width * .05),
            child: Column(
              spacing: height * .02,
              children: [
                CustomGenderOption(
                  onTap: () {
                    context.read<RegisterViewModel>().doIntent(
                      SaveGenderEvent(Gender.male.name),
                    );
                  },
                  selected:
                      context.watch<RegisterViewModel>().state.gender ==
                      Gender.male.name,
                  icon: AppAssets.maleIcon,
                  label: locale.male,
                ),
                CustomGenderOption(
                  onTap: () {
                    context.read<RegisterViewModel>().doIntent(
                      SaveGenderEvent(Gender.female.name),
                    );
                  },
                  selected:
                      context.watch<RegisterViewModel>().state.gender ==
                      Gender.female.name,
                  icon: AppAssets.femaleIcon,
                  label: locale.female,
                ),
                CustomElevatedButton(
                  isLoading: false,
                  onPressed:
                      context.watch<RegisterViewModel>().state.gender == null
                      ? null
                      : () {
                          context
                              .read<RegisterViewModel>()
                              .pageController
                              .nextPage(
                                duration: const Duration(
                                  milliseconds: AppConstants.registerDuration,
                                ),
                                curve: Curves.easeIn,
                              );
                        },
                  widget: Text(context.localization.next),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
