sealed class HomeEvent {}

class RecommendationToDayEvent extends HomeEvent {}

class RecommendationForYouEvent extends HomeEvent {}

class UpcomingWorkoutsTabEvent extends HomeEvent {}

class GetUserProfileEvent extends HomeEvent {}

class UpcomingWorkoutsTabItemsEvent extends HomeEvent {
  String musclesGroupId;

  UpcomingWorkoutsTabItemsEvent({required this.musclesGroupId});
}

class GetAllHomeDataEvent extends HomeEvent {}
