sealed class FoodScreenEvent {}

class GetMealsByCategoryEvent extends FoodScreenEvent {
  final String categoryName;
  GetMealsByCategoryEvent(this.categoryName);
}
