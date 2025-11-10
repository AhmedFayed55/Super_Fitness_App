import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_event.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/activity_body.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/custom_blur_container.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/goal_selector.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/number_selector.dart';

class WGABody extends StatefulWidget {
  const WGABody({super.key});

  @override
  State<WGABody> createState() => _WGABodyState();
}

class _WGABodyState extends State<WGABody> {
  String? selectedActivity;
  String? selectedGoal;
  int? selectedWeight;

  @override
  void initState() {
    var cubit = context.read<EditProfileCubit>();
    selectedActivity = cubit.state.user?.activityLevel;
    selectedGoal = cubit.state.user?.goal;
    selectedWeight = cubit.state.user?.weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EditProfileCubit>();
    var trans = context.localization;

    var currentEdit = cubit.state.selectedEdits.name;
    var user = cubit.state.user!;
    final List<String> goals = [
      context.localization.gain_weight,
      context.localization.lose_weight,
      context.localization.get_fitter,
      context.localization.gain_more_flexible,
      context.localization.learn_the_basic,
    ];
    final List<String> activities = [
      context.localization.rookie,
      context.localization.beginner,
      context.localization.intermediate,
      context.localization.advance,
      context.localization.true_beast,
    ];
    return Column(
      children: [
        verticalSpace(context.mdH(46)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: context.mdH(50),
              width: context.mdW(72),
              child: Image.asset(AppAssets.appLogo),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${trans.what_is_your} $currentEdit ?",
                          style: context.textTheme.displayMedium,
                        ),
                        Text(
                          trans.this_helps_us,
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(context.mdH(16)),
              CustomBlurContainerFields(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      switch (state.selectedEdits) {
                        case Edits.weight:
                          return SelectNumber(
                            value: selectedWeight ?? 0,
                            min: 0,
                            max: 300,
                            onChanged: (int p1) {
                              setState(() {
                                selectedWeight = p1;
                              });
                            },
                            onPressed: () {
                              context.pop();
                              cubit.doIntant(
                                ChangeWeightEvent(weight: selectedWeight!),
                              );
                              cubit.navigatToEditsScreen(Edits.none);
                            },
                            buttonText: trans.done,
                          );

                        case Edits.goal:
                          return GoalSelector(
                            goals: goals,
                            selectedGoal: selectedGoal ?? user.goal,
                            onSelect: (String value) {
                              setState(() {
                                selectedGoal = value;
                              });
                            },
                            onNext: () {
                              context.pop();
                              cubit.doIntant(
                                ChangeGoalEvent(goal: selectedGoal!),
                              );
                              cubit.navigatToEditsScreen(Edits.none);
                            },
                          );
                        case Edits.activity:
                          return ActivitySelector(
                            activities: activities,
                            selectedActivity:
                                selectedActivity ?? user.activityLevel,
                            onSelect: (String value) {
                              setState(() {
                                selectedActivity = value;
                              });
                            },
                            onNext: () {
                              cubit.doIntant(
                                ChangeActivityEvent(
                                  activityLevel: selectedActivity!,
                                ),
                              );
                              cubit.navigatToEditsScreen(Edits.none);
                              context.pop();
                            },
                          );

                        case Edits.none:
                          return Text(trans.something_went_wrong);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
