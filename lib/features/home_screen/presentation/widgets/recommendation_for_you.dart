import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/shimmers/home_screen_shimmers.dart';

class RecommendationForYou extends StatefulWidget {
  const RecommendationForYou({super.key});

  @override
  State<RecommendationForYou> createState() => _RecommendationForYouState();
}

class _RecommendationForYouState extends State<RecommendationForYou> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubitState = state.forYouData?.categoriesDtoEntity;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Skeletonizer(
                enabled: state.forYou == ScreenStatus.isLoading,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.localization.recommendation_for_you,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    InkWell(
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.foodScreen,
                          arguments: {
                            "CategoryName": "",
                            "list": state.forYouData?.categoriesDtoEntity,
                          },
                        );
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
            ),
            verticalSpace(screenHeight * 0.01),
            if (state.forYou == ScreenStatus.isLoading)
              const UpcomingWorkoutsItemsShimmer()
            else if (state.forYou == ScreenStatus.isError)
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
                        context.pushNamed(
                          AppRoutes.foodScreen,
                          arguments: {
                            "index": index,
                            "list": state.forYouData?.categoriesDtoEntity,
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:
                                (cubitState?[index].strCategoryThumb == null ||
                                    cubitState![index].strCategoryThumb.isEmpty)
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.grey[10]!,
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
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(20),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.grey[20]!,
                                      ),
                                    ),
                                    child: Image.network(
                                      cubitState[index].strCategoryThumb,
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
                                                child:
                                                    CircularProgressIndicator(
                                                      color: AppColors
                                                          .lightOrange[10],
                                                    ),
                                              ),
                                            );
                                          },
                                    ),
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
                                color: AppColors.grey[10]?.withValues(
                                  alpha: 0.7,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cubitState?[index].strCategory ??
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
