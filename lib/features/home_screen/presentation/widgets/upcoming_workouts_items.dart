import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';

class UpcomingWorkoutsItems extends StatelessWidget {
  const UpcomingWorkoutsItems({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubitState = state.upcomingTabItemsData?.musclesDtoEntity;
        if (state.upcomingTabItems == ScreenStatus.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.lightOrange[10]),
          );
        } else if (state.upcomingTabItemsData?.musclesDtoEntity == null ||
            state.upcomingTabItemsData!.musclesDtoEntity.isEmpty) {
          return Container(
            alignment: Alignment.center,
            height: screenHeight * 0.1,
            child: Text(
              context.localization.nothing_exists,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        } else {
          return SizedBox(
            height: screenHeight * 0.1,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: cubitState?.length ?? 0,
              separatorBuilder: (context, index) {
                return horizontalSpace(screenWidth * 0.043);
              },
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          (cubitState?[index].image == null ||
                              cubitState![index].image.isEmpty)
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.grey[20]!,
                                ),
                              ),
                              alignment: Alignment.center,
                              height: screenHeight * 0.1,
                              width: screenHeight * 0.1,
                              child: const Icon(
                                Icons.error_outline,
                                size: 30,
                                color: AppColors.grey,
                              ),
                            )
                          : Image.network(
                              cubitState[index].image,
                              fit: BoxFit.fill,
                              height: screenHeight * 0.1,
                              width: screenHeight * 0.1,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: screenHeight * 0.1,
                                        width: screenHeight * 0.1,
                                        child: CircularProgressIndicator(
                                          color: AppColors.lightOrange[10],
                                        ),
                                      ),
                                    );
                                  },
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.027,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.grey[10]?.withValues(alpha: 0.9),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          cubitState?[index].name ?? context.localization.error,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
