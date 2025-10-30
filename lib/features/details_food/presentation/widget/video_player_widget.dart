import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_arrow_back.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_blur_container.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_circle.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var locale = context.localization;
    var cubit = context.read<DetailsFoodViewModel>();
    return BlocBuilder<DetailsFoodViewModel, DetailsFoodState>(
      builder: (context, state) {
        final controller = state.youtubeController;

        if (controller == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Align(
          child: CustomBlurContainer(
            height: context.mdH(400),
            child: Stack(
              children: [
                YoutubePlayer(controller: controller, aspectRatio: 4 / 3),
                const Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: ArrowBackButton(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        cubit.state.detailsFoodEntity!.name ,
                        style: theme.labelLarge!.copyWith(fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.detailsFoodEntity?.ingredients[2].name??'0000999',
                        //  'Lorem ipsum dolor sit amet consectetur. Tempus volutpat ut nisi morbi. ',
                          style: theme.bodyLarge,
                        ),
                      ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
