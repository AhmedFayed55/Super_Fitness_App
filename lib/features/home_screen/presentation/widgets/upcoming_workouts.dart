import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';

import 'tab_item.dart';

class UpcomingWorkouts extends StatefulWidget {
  const UpcomingWorkouts({super.key});

  @override
  State<UpcomingWorkouts> createState() => _UpcomingWorkoutsState();
}

class _UpcomingWorkoutsState extends State<UpcomingWorkouts> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 8,
          child: TabBar(
            onTap: (value) {
              selectedIndex = value;
              setState(() {});
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.transparent,
            unselectedLabelStyle: TextStyle(color: AppColors.white),
            tabs: state.upcomingTabData!.musclesGroupDtoEntity
                .map(
                  (e) => Tab(
                    child: TabItem(
                      musclesGroupDtoEntity: e,
                      selected:
                          state.upcomingTabData!.musclesGroupDtoEntity
                              .elementAt(selectedIndex) == e,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
