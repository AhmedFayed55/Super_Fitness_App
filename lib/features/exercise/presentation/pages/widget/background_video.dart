import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/custom_circlure_shape.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BackgroundVideo extends StatelessWidget {
  const BackgroundVideo({super.key});

  final double bgVideoHeight = 300;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      buildWhen: (previous, current) =>
          previous.videoController != current.videoController,
      builder: (context, state) {
        final controller = state.videoController;
        if (controller == null) {
          return Container(
            width: context.width,
            height: context.mdH(bgVideoHeight),
            color: AppColors.cmykColor,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: context.theme.colorScheme.primary,
            ),
          );
        }

        return Stack(
          children: [
            SizedBox(
              width: context.width,
              height: context.mdH(bgVideoHeight),
              child: FittedBox(
                fit: BoxFit.cover,
                child: YoutubePlayer(
                  controller: controller,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.transparent,
                    handleColor: Colors.transparent,
                  ),
                  showVideoProgressIndicator: false,
                  onReady: () => controller.play(),
                ),
              ),
            ),

            Container(
              height: context.mdH(bgVideoHeight),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.cmykColor,
                    AppColors.cmykColor.withValues(alpha: 0.8),
                    AppColors.cmykColor.withValues(alpha: 0.3),
                    AppColors.cmykColor.withValues(alpha: 0.2),
                    AppColors.cmykColor.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      state.data.exercises.first.targetMuscleGroup ?? "",
                      style: context.textTheme.displayLarge,
                    ),
                    verticalSpace(context.mdH(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mdW(24),
                      ),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        'This is a description of the exercise. It provides details about how to perform the exercise correctly and safely.',
                        style: context.textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: context.mdH(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCirclureShape(
                          child: Text(
                            '30 mins',
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                        CustomCirclureShape(
                          child: Text(
                            '130 Cal',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(context.mdH(8)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
