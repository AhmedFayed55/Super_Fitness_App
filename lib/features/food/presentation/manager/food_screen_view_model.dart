import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'package:super_fitness_app/features/food/domain/use_cases/get_food_categories.dart';
import 'package:super_fitness_app/features/food/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_event.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_state.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';

@injectable
class FoodScreenViewModel extends Cubit<FoodScreenState> {
  FoodScreenViewModel(
    this._getFoodCategoriesUseCase,
    this._getMealsByCategoryUseCase,
  ) : super(const FoodScreenState());
  final GetFoodCategoriesUseCase _getFoodCategoriesUseCase;
  final GetMealsByCategoryUseCase _getMealsByCategoryUseCase;

  doIntent(FoodScreenEvent event) {
    switch (event) {
      case GetFoodCategoriesEvent():
        return _getFoodCategories();
      case GetMealsByCategoryEvent(:final categoryName):
        return _getMealsByCategory(categoryName);
    }
  }

  Future<void> _getFoodCategories() async {
    emit(
      state.copyWith(
        isCategoriesLoading: true,
        categoriesError: null,
        categories: null,
      ),
    );
    final response = await _getFoodCategoriesUseCase.call();
    switch (response) {
      case ApiSuccessResult<MealsCategoriesEntity>():
        emit(
          state.copyWith(
            isCategoriesLoading: false,
            categories: response.data.categoriesDtoEntity,
          ),
        );
      case ApiErrorResult<MealsCategoriesEntity>():
        emit(
          state.copyWith(
            categoriesError: response.failure.errorMessage,
            isCategoriesLoading: false,
          ),
        );
    }
  }

  Future<void> _getMealsByCategory(String categoryName) async {
    if (state.cachedMeals != null &&
        state.cachedMeals!.containsKey(categoryName)) {
      emit(
        state.copyWith(
          meals: state.cachedMeals![categoryName],
          isMealsLoading: false,
        ),
      );
      return;
    }
    emit(state.copyWith(isMealsLoading: true, mealsError: null, meals: null));
    final response = await _getMealsByCategoryUseCase.call(categoryName);
    switch (response) {
      case ApiSuccessResult<List<MealsResponseEntity>>():
        final updatedCache = Map<String, List<MealsResponseEntity>>.from(
          state.cachedMeals ?? {},
        );
        updatedCache[categoryName] = response.data;
        emit(
          state.copyWith(
            isMealsLoading: false,
            meals: response.data,
            cachedMeals: updatedCache,
          ),
        );
      case ApiErrorResult<List<MealsResponseEntity>>():
        emit(
          state.copyWith(
            isMealsLoading: false,
            mealsError: response.failure.errorMessage,
          ),
        );
    }
  }
}
