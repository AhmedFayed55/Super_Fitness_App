import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsFoodState {
  final bool isLoading;
  final String errorMessage;
  final YoutubePlayerController? youtubeController;
  final DetailsFoodEntity? detailsFoodEntity;

  DetailsFoodState({
    this.detailsFoodEntity,
    this.isLoading = false,
    this.errorMessage = '',
    this.youtubeController,
  });

  DetailsFoodState copyWith({
    DetailsFoodEntity? detailsFoodEntity,
    bool? isLoading,
    String? errorMessage,
    YoutubePlayerController? youtubeController,
  }) {
    return DetailsFoodState(
      detailsFoodEntity: detailsFoodEntity ?? this.detailsFoodEntity,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      youtubeController: youtubeController ?? this.youtubeController,
    );
  }
}
