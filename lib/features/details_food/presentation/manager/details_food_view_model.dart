import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/details_food/domain/use_case/details_food_use_case.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_event.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@injectable
class DetailsFoodViewModel extends Cubit<DetailsFoodState> {
  final DetailsFoodUseCase _detailsFoodUseCase;
  DetailsFoodViewModel(this._detailsFoodUseCase) : super(DetailsFoodState());

  @override
  Future<void> close() {
    state.youtubeController?.dispose();
    return super.close();
  }

  void doIntent(DetailsFoodEvent event) {
    switch (event) {
      case DetailsDataFoodEvent():
        _getDetailsData(event.idMeal);
    }
  }

  Future<void> _getDetailsData(String mealId) async {
    emit(state.copyWith(isLoading: true));

    final result = await _detailsFoodUseCase.call(mealId);

    switch (result) {
      case ApiSuccessResult():
        final controller = _initYoutubeVideo(result.data.youtubeUrl);
        emit(
          state.copyWith(
            isLoading: false,
            detailsFoodEntity: result.data,
            youtubeController: controller,
          ),
        );
        break;

      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure.errorMessage,
          ),
        );
        break;
    }
  }

  YoutubePlayerController? _initYoutubeVideo(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId == null) return null;

    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        hideThumbnail: true,
        hideControls: false,
      ),
    );
  }
}