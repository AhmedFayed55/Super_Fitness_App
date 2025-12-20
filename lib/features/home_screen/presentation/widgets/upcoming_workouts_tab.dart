import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_event.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/shimmers/home_screen_shimmers.dart';

import 'tab_item.dart';

class UpcomingWorkoutsTab extends StatefulWidget {
  final Function onClicked;
  const UpcomingWorkoutsTab({super.key,required this.onClicked});

  @override
  State<UpcomingWorkoutsTab> createState() => _UpcomingWorkoutsTabState();
}

class _UpcomingWorkoutsTabState extends State<UpcomingWorkoutsTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = context.height;

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      previous.upcomingTabData != current.upcomingTabData,
      builder: (context, state) {
        var cubitState = state.upcomingTabData;
        var homeCubit = context.read<HomeCubit>();

        if (state.upcomingTab == ScreenStatus.isLoading || cubitState == null) {
          return const UpcomingWorkoutsTabShimmer();
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localization.upcoming_workouts,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  InkWell(
                    onTap: () {
                      widget.onClicked();
                    },
                    child: Text(
                      context.localization.see_all,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightOrange[10],
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.lightOrange[10],
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(screenHeight * 0.01),

            DefaultTabController(
              length: cubitState.musclesGroupDtoEntity.length,
              child: TabBar(
                onTap: (value) {
                  selectedIndex = value;
                  setState(() {});
                  homeCubit.doIntent(
                    UpcomingWorkoutsTabItemsEvent(
                      musclesGroupId: cubitState
                          .musclesGroupDtoEntity[selectedIndex].id,
                    ),
                  );
                },
                isScrollable: true,
                indicator: const BoxDecoration(),
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                tabs: cubitState.musclesGroupDtoEntity
                    .map(
                      (e) => Tab(
                    child: TabItem(
                      musclesGroupDtoEntity: e,
                      selected: cubitState.musclesGroupDtoEntity
                          .elementAt(selectedIndex) ==
                          e,
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}