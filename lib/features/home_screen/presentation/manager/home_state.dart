import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';

enum ScreenStatus { initial, isLoading, isSuccess, isError }

class HomeState {
  final ScreenStatus today;
  final ScreenStatus forYou;
  final ScreenStatus upcomingTab;
  final ScreenStatus upcomingTabItems;

  final MusclesRandomEntity? todayData;
  final MealsCategoriesEntity? forYouData;
  final GetAllMusclesEntity? upcomingTabData;
  final MusclesGroupIdEntity? upcomingTabItemsData;
  final UserDataResponseEntity? userData;
  final bool? isLoadingImage;
  final bool? isSuccessImage;
  final bool? isErrorImage;

  const HomeState({
    this.today = ScreenStatus.initial,
    this.forYou = ScreenStatus.initial,
    this.upcomingTab = ScreenStatus.initial,
    this.upcomingTabItems = ScreenStatus.initial,
    this.todayData,
    this.forYouData,
    this.upcomingTabData,
    this.upcomingTabItemsData,
    this.userData,
    this.isLoadingImage,
    this.isSuccessImage,
    this.isErrorImage,
  });

  HomeState copyWith({
    ScreenStatus? today,
    ScreenStatus? forYou,
    ScreenStatus? upcomingTab,
    ScreenStatus? upcomingTabItems,
    MusclesRandomEntity? todayData,
    MealsCategoriesEntity? forYouData,
    GetAllMusclesEntity? upcomingTabData,
    MusclesGroupIdEntity? upcomingTabItemsData,
    UserDataResponseEntity? userData,
    bool? isLoadingImage,
    bool? isSuccessImage,
    bool? isErrorImage,
  }) {
    return HomeState(
      today: today ?? this.today,
      forYou: forYou ?? this.forYou,
      upcomingTab: upcomingTab ?? this.upcomingTab,
      upcomingTabItems: upcomingTabItems ?? this.upcomingTabItems,
      todayData: todayData ?? this.todayData,
      forYouData: forYouData ?? this.forYouData,
      upcomingTabData: upcomingTabData ?? this.upcomingTabData,
      upcomingTabItemsData: upcomingTabItemsData ?? this.upcomingTabItemsData,
      userData: userData ?? this.userData,
      isLoadingImage: isLoadingImage ?? this.isLoadingImage,
      isSuccessImage: isSuccessImage ?? this.isSuccessImage,
      isErrorImage: isErrorImage ?? this.isErrorImage,
    );
  }
}
