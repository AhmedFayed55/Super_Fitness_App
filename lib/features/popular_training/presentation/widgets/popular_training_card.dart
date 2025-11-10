import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/custom_circuler_container.dart';

class PopularTrainingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String level;
  final String tasksCount;
  final VoidCallback? onTap;

  const PopularTrainingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.level,
    required this.tasksCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // var videoId = YoutubePlayer.convertUrlToId(imageUrl) ?? "azjQG10quYw";
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.mdW(200),
        height: context.mdH(176),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: Image.network(
              height: double.infinity,
              'https://media.gettyimages.com/id/1493959975/photo/young-man-working-out-with-battle-ropes-in-gym.jpg?s=612x612&w=gi&k=20&c=6v8bbiCv8K3CCX8667aerKyIadronMzwT7U2Rz2zfNw=',
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text(
                    title,
                    style: context.textTheme.displaySmall?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCirculerContainer(
                        child: Text(
                          "$tasksCount Tasks",
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      CustomCirculerContainer(
                        child: Text(
                          level,
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontSize: 12,
                            color: context.colorScheme.primary,
                          ),
                        ),
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
  }
}
