sealed class DetailsFoodEvent {}

class DetailsDataFoodEvent extends DetailsFoodEvent {
  String idMeal;
  DetailsDataFoodEvent({required this.idMeal});
}
