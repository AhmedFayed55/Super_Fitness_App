import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:super_fitness_app/features/details_food/domain/use_case/details_food_use_case.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_event.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@injectable
class DetailsFoodViewModel extends Cubit<DetailsFoodState> {
  final DetailsFoodUseCase _detailsFoodUseCase;
  DetailsFoodViewModel(this._detailsFoodUseCase) : super(DetailsFoodState());
  late YoutubePlayerController _youtubeController;

  void doIntent(DetailsFoodEvent event) {
      print(">>>>>>>>>> doIntent called with $event");

    switch (event) {
      case DetailsDataFoodEvent():
        _getDetailsData(event.idMeal);
    }
  }

  @override
  Future<void> close() {
    _youtubeController.dispose();
    return super.close();
  }

  Future<void> _getDetailsData(String mealId) async {
      print(">>>>>>>>>> _getDetailsData called with $mealId");

    emit(state.copyWith(isLoading: true));
    var result = await _detailsFoodUseCase.call(mealId);
  print(">>>>>>>>>> _getDetailsData called with $mealId");

    switch (result) {
      case ApiSuccessResult():
        _initYoutubeVideo(result.data.youtubeUrl);
        print(">>>>>>>>>>>>>${result.data.youtubeUrl}");
        emit(state.copyWith(isLoading: false, detailsFoodEntity: result.data));
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure.errorMessage,
          ),
        );
    }
  }

//  Future<void> _getDetailsData(String mealId) async {
//   emit(state.copyWith(isLoading: true));

//   final result = await _detailsFoodUseCase.call(mealId);
//   print(">>>>>>>>>> result runtimeType = ${result.runtimeType}");

//   if (result is ApiSuccessResult<DetailsFoodEntity>) {
//     print("✅ SUCCESS: ${result.data}");
//     _initYoutubeVideo(result.data.youtubeUrl);
//     emit(state.copyWith(
//       isLoading: false,
//       detailsFoodEntity: result.data,
//     ));
//   } else if (result is ApiErrorResult<DetailsFoodEntity>) {
//     print("❌ ERROR: ${result.failure.errorMessage}");
//     emit(state.copyWith(
//       isLoading: false,
//       errorMessage: result.failure.errorMessage,
//     ));
//   } else {
//     print("⚠️ Unknown result type: ${result.runtimeType}");
//   }
// }



  void _initYoutubeVideo(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId == null) {
      return;
    }
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    emit(state.copyWith(youtubeController: _youtubeController));
  }
}
