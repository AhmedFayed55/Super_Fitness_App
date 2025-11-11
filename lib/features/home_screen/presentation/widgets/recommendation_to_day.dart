import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';

class RecommendationToDay extends StatefulWidget {
  const RecommendationToDay({super.key});

  @override
  State<RecommendationToDay> createState() => _RecommendationToDayState();
}

class _RecommendationToDayState extends State<RecommendationToDay> {

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubitState = state.todayData?.musclesDtoEntity;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Skeletonizer(
                enabled: state.today == ScreenStatus.isLoading,
                child: Text(
                  context.localization.recommendation_to_day,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            verticalSpace(screenHeight * 0.01),
            if (state.today == ScreenStatus.isLoading)
              SizedBox(
                height: screenWidth * 0.28,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.lightOrange[10],
                  ),
                ),
              )
            else if (state.today == ScreenStatus.isError)
              Center(
                child: Text(
                  context.localization.something_went_wrong,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            else
              SizedBox(
                height: screenWidth * 0.28,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cubitState?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return horizontalSpace(screenWidth * 0.043);
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // print("${cubitState?[index].id}");
                      },
                      child: Stack(
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
                                    height: screenWidth * 0.28,
                                    width: screenWidth * 0.28,
                                    child: const Icon(
                                      Icons.error_outline,
                                      size: 30,
                                      color: AppColors.grey,
                                    ),
                                  )
                                : Image.network(
                                    cubitState[index].image,
                                    fit: BoxFit.fill,
                                    height: screenWidth * 0.28,
                                    width: screenWidth * 0.28,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: screenWidth * 0.28,
                                              width: screenWidth * 0.28,
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
                              height: screenHeight * 0.037,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.grey[10]?.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cubitState?[index].name ??
                                    context.localization.error,
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
