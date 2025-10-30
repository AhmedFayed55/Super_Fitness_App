import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise});
  final ExerciseEntity exercise;

  void _showVideoPopup(BuildContext context, String videoId) {
    if (videoId.isEmpty) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "videoPopup",
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Stack(
            children: [
              
              Container(color: Colors.black.withValues(alpha: 0.4)),

            
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: _YouTubePlayerPopup(videoId: videoId),
                ),
              ),
            ],
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var videoId =
        YoutubePlayer.convertUrlToId(
          exercise.shortYoutubeDemonstrationLink ??
              exercise.inDepthYoutubeExplanationLink ??
              "",
        ) ??
        "";
    String playedVideoId =
        YoutubePlayer.convertUrlToId(
          exercise.inDepthYoutubeExplanationLink ??
              exercise.shortYoutubeDemonstrationLink ??
              "",
        ) ??
        "";

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(context.mdRadius(20)),
          child: Image.network(
            videoId.isNotEmpty
                ? 'https://img.youtube.com/vi/$videoId/0.jpg'
                : "https://www.hdfcergo.com/images/default-source/wellness-corner/benefits-of-regular-physical-activity_m.jpg",
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                ? child
                : SizedBox(
                    height: context.mdH(88),
                    width: context.mdW(81),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
            errorBuilder: (context, error, stackTrace) => SizedBox(
              height: context.mdH(88),
              width: context.mdW(81),
              child: const Icon(Icons.error),
            ),
            fit: BoxFit.cover,
            height: context.mdH(88),
            width: context.mdW(81),
          ),
        ),
        horizontalSpace(context.mdW(17)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.mdW(150),
              child: Text(
                exercise.exercise,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelLarge,
              ),
            ),
            verticalSpace(context.mdH(4)),
            Text(
              "3 groups * 15 times\nLorem ipsum dolor sit\namet consectetur.",
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => _showVideoPopup(context, playedVideoId),
          child: CircleAvatar(
            radius: context.mdW(16),
            backgroundColor: context.colorScheme.primary,
            child: Icon(
              size: context.mdH(24),
              Icons.play_arrow,
              color: AppColors.cmykColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _YouTubePlayerPopup extends StatefulWidget {
  const _YouTubePlayerPopup({required this.videoId});
  final String videoId;

  @override
  State<_YouTubePlayerPopup> createState() => _YouTubePlayerPopupState();
}

class _YouTubePlayerPopupState extends State<_YouTubePlayerPopup> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: context.mdW(300),
        height: context.mdH(200),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller),
          builder: (context, player) {
            return player;
          },
        ),
      ),
    );
  }
}
