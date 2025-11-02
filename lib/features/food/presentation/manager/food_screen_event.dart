sealed class FoodScreenEvent {}

class GetFoodCategoriesEvent extends FoodScreenEvent {}

class GetMealsByCategoryEvent extends FoodScreenEvent {
  final String categoryName;
  GetMealsByCategoryEvent(this.categoryName);
}
