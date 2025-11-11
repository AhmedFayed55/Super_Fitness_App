import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/get_profile_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/recommendation_for_you/recommendation_for_you_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/recommendation_to_day/recommendation_to_day_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/get_all_muscles_response_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/muscles_group_id_response_usecase.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_event.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final RecommendationToDayUseCase _recommendationToDayUseCase;
  final RecommendationForYouUseCase _recommendationForYouUseCase;
  final GetAllMusclesResponseUseCase _upcomingWorkoutsTabUseCase;
  final MusclesGroupIdResponseUseCase _upcomingWorkoutsTabItemsUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  HomeCubit(
    this._recommendationToDayUseCase,
    this._recommendationForYouUseCase,
    this._upcomingWorkoutsTabUseCase,
    this._upcomingWorkoutsTabItemsUseCase,
    this._getUserProfileUseCase,
  ) : super(const HomeState());

  Future<void> doIntent(HomeEvent event) async {
    switch (event) {
      case RecommendationToDayEvent():
        _recommendationToDay();
        break;
      case RecommendationForYouEvent():
        _recommendationForYou();
        break;
      case UpcomingWorkoutsTabEvent():
        _upcomingWorkoutsTab();
        break;
      case UpcomingWorkoutsTabItemsEvent():
        _upcomingWorkoutsTabItems(event.musclesGroupId);
        break;
       case GetUserProfileEvent():
         _getUserProfile();
        break;
      case GetAllHomeDataEvent():
        _getAllHomeData();
        break;
    }
  }

  Future<void> _recommendationToDay() async {
    emit(state.copyWith(today: ScreenStatus.isLoading));
    var result = await _recommendationToDayUseCase.call();
    if (result is ApiSuccessResult<MusclesRandomEntity>) {
      emit(
        state.copyWith(today: ScreenStatus.isSuccess, todayData: result.data),
      );
    }
    if (result is ApiErrorResult<MusclesRandomEntity>) {
      emit(state.copyWith(today: ScreenStatus.isError));
    }
  }

  Future<void> _recommendationForYou() async {
    emit(state.copyWith(forYou: ScreenStatus.isLoading));
    var result = await _recommendationForYouUseCase.call();
    if (result is ApiSuccessResult<MealsCategoriesEntity>) {
      emit(
        state.copyWith(forYou: ScreenStatus.isSuccess, forYouData: result.data),
      );
    }
    if (result is ApiErrorResult<MealsCategoriesEntity>) {
      emit(state.copyWith(forYou: ScreenStatus.isError));
    }
  }

  Future<void> _upcomingWorkoutsTab() async {
    emit(state.copyWith(upcomingTab: ScreenStatus.isLoading));
    var result = await _upcomingWorkoutsTabUseCase.call();
    if (result is ApiSuccessResult<GetAllMusclesEntity>) {
      emit(
        state.copyWith(
          upcomingTab: ScreenStatus.isSuccess,
          upcomingTabData: result.data,
        ),
      );
    }
    if (result is ApiErrorResult<GetAllMusclesEntity>) {
      emit(state.copyWith(upcomingTab: ScreenStatus.isError));
    }
  }

  Future<void> _upcomingWorkoutsTabItems(String muscleGroupId) async {
    emit(state.copyWith(upcomingTabItems: ScreenStatus.isLoading));
    var result = await _upcomingWorkoutsTabItemsUseCase.call(muscleGroupId);
    if (result is ApiSuccessResult<MusclesGroupIdEntity>) {
      emit(
        state.copyWith(
          upcomingTabItems: ScreenStatus.isSuccess,
          upcomingTabItemsData: result.data,
        ),
      );
    }
    if (result is ApiErrorResult<MusclesGroupIdEntity>) {
      emit(state.copyWith(upcomingTabItems: ScreenStatus.isError));
    }
  }

  Future<void> _getUserProfile() async {
    emit(state.copyWith(isLoadingImage: true));
    var result = await _getUserProfileUseCase.call();
    if (result is ApiSuccessResult<UserDataResponseEntity>) {
      emit(
        state.copyWith(
          isLoadingImage: false,
          userData: result.data,
          isSuccessImage: true
        ),
      );
    }
    if (result is ApiErrorResult<UserDataResponseEntity>) {
      emit(state.copyWith(isLoadingImage: false,isErrorImage: true));
    }
  }

  Future<void> _getAllHomeData() async {
    await Future.wait([
      _recommendationToDay(),
      _recommendationForYou(),
      _upcomingWorkoutsTab(),
      _upcomingWorkoutsTabItems("67c79f3526895f87ce0aa96b"),
      _getUserProfile(),
    ]);
  }
}
