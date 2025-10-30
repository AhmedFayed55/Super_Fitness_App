import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import '../../../home_screen/domain/entities/recommendation_for_you/categories_entity.dart';

class FoodScreenState extends Equatable {
  final bool isCategoriesLoading;
  final String? categoriesError;
  final List<CategoriesEntity>? categories;

  final bool isMealsLoading;
  final String? mealsError;
  final List<MealsResponseEntity>? meals;
  final Map<String, List<MealsResponseEntity>>? cachedMeals;

  const FoodScreenState({
    this.isCategoriesLoading = false,
    this.categoriesError,
    this.categories,
    this.isMealsLoading = false,
    this.mealsError,
    this.meals,
    this.cachedMeals,
  });

  FoodScreenState copyWith({
    bool? isCategoriesLoading,
    String? categoriesError,
    List<CategoriesEntity>? categories,
    bool? isMealsLoading,
    String? mealsError,
    List<MealsResponseEntity>? meals,
    Map<String, List<MealsResponseEntity>>? cachedMeals,
  }) {
    return FoodScreenState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      categoriesError: categoriesError,
      categories: categories ?? this.categories,
      isMealsLoading: isMealsLoading ?? this.isMealsLoading,
      mealsError: mealsError,
      meals: meals ?? this.meals,
      cachedMeals: cachedMeals ?? this.cachedMeals,
    );
  }

  @override
  List<Object?> get props => [
    isCategoriesLoading,
    categoriesError,
    categories,
    isMealsLoading,
    mealsError,
    meals,
    cachedMeals,
  ];
}
