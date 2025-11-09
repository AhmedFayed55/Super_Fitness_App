import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';

class FoodScreenState extends Equatable {
  final bool isMealsLoading;
  final String? mealsError;
  final List<MealsResponseEntity>? meals;
  final Map<String, List<MealsResponseEntity>>? cachedMeals;

  const FoodScreenState({
    this.isMealsLoading = false,
    this.mealsError,
    this.meals,
    this.cachedMeals,
  });

  FoodScreenState copyWith({
    bool? isMealsLoading,
    String? mealsError,
    List<MealsResponseEntity>? meals,
    Map<String, List<MealsResponseEntity>>? cachedMeals,
  }) {
    return FoodScreenState(
      isMealsLoading: isMealsLoading ?? this.isMealsLoading,
      mealsError: mealsError,
      meals: meals ?? this.meals,
      cachedMeals: cachedMeals ?? this.cachedMeals,
    );
  }

  @override
  List<Object?> get props => [isMealsLoading, mealsError, meals, cachedMeals];
}
