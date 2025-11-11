import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_arrow_back.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_circle.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var cubit = context.read<DetailsFoodViewModel>();
    return BlocBuilder<DetailsFoodViewModel, DetailsFoodState>(
      builder: (context, state) {
        final controller = state.youtubeController;

        if (controller == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            SizedBox(
              height: context.mdH(330),
              child: FittedBox(
                fit: BoxFit.cover,
                child: YoutubePlayer(
                  controller: controller,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.transparent,
                    handleColor: Colors.transparent,
                  ),
                  showVideoProgressIndicator: false,
                ),
              ),
            ),

            Container(
              height: context.mdH(330),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.cmyKColor,
                    AppColors.cmyKColor.withValues(alpha: 0.8),
                    AppColors.cmyKColor.withValues(alpha: 0.3),
                    AppColors.cmyKColor.withValues(alpha: 0.2),
                    AppColors.cmyKColor.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mdW(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      cubit.state.detailsFoodEntity!.name,
                      style: context.textTheme.displayLarge,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      cubit.state.detailsFoodEntity!.instructions,
                      style: context.textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: context.mdH(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCircle(
                          name: locale.energy,
                          countyItem: AppConstants.countyEnergy,
                        ),
                        CustomCircle(
                          name: locale.protein,
                          countyItem: AppConstants.countyProtein,
                        ),
                        CustomCircle(
                          name: locale.carbs,
                          countyItem: AppConstants.countyCarbs,
                        ),
                        CustomCircle(
                          name: locale.fat,
                          countyItem: AppConstants.countyFat,
                        ),
                      ],
                    ),
                    verticalSpace(context.mdH(8)),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: AlignmentGeometry.topLeft,
              child: ArrowBackButton(),
            ),
          ],
        );
      },
    );
  }
}
