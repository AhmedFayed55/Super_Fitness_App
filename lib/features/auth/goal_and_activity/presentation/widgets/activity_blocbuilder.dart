import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/flutter_toast.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_event.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';

import '../../../../../core/helpers/enum.dart';

class ActivityBlocBuilder extends StatelessWidget {
  const ActivityBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegisterViewModel>();
    // var cubitState = context.read<RegisterViewModel>().state;
    var selectedActivityLevel  = "";
    final List<String> activities = [
      context.localization.rookie,
      context.localization.beginner,
      context.localization.intermediate,
      context.localization.advance,
      context.localization.true_beast,
    ];
    var screenWidth = context.width;
    var screenHeight = context.height;
    return BlocConsumer<RegisterViewModel, RegisterState>(
      listener: (context, state) {
        if(state.isSuccess){
          ToastMessage.toastMsg(context.localization.register_successfully);
          Future.delayed(const Duration(milliseconds: 500),() {
            context.pushNamedAndRemoveUntil(AppRoutes.login, predicate: (route) => false,);
          });
        } else if(state.isError && state.showToast){
          ToastMessage.toastMsg(context.localization.something_went_wrong,backgroundColor: context.colorScheme.error);
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            bottom: screenHeight * 0.030,
            right: screenWidth * 0.043,
            left: screenWidth * 0.043,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff242424).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: [
              ListView.separated(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.030,
                  left: screenWidth * 0.043,
                  right: screenWidth * 0.043,
                  bottom: screenHeight * 0.030,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth * 0.83,
                    height: screenHeight * 0.044,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.white),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.043,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activities[index],
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.white),
                        ),
                        RadioGroup(
                          groupValue: state.activitySelected,
                          onChanged: (value) {
                            selectedActivityLevel = ActivityLevel.values[activities.indexOf(value!)].name;
                            cubit.doIntent(
                              OnSelectedActivityEvent(activity: value),
                            );
                          },
                          child: Radio(
                            value: activities[index],
                            side: const BorderSide(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(screenHeight * 0.020);
                },
                itemCount: activities.length,
              ),
              CustomElevatedButton(
                onPressed: state.activitySelected != null ? () {
                  /// Button OnPressed
                  context.read<RegisterViewModel>().doIntent(SubmitRegisterEvent(activityLevel: selectedActivityLevel));
                } : null,
                isLoading: state.isLoading,
                widget: Text(context.localization.next),
              ),
            ],
          ),
        );
      },
    );
  }
}