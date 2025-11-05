import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'package:super_fitness_app/features/food/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_event.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_view_model.dart';
import 'food_screen_view_model_test.mocks.dart';

@GenerateMocks([GetMealsByCategoryUseCase])
void main() {
  late GetMealsByCategoryUseCase mockGetMealsByCategoryUseCase;
  late FoodScreenViewModel viewModel;

  setUp(() {
    mockGetMealsByCategoryUseCase = MockGetMealsByCategoryUseCase();
    viewModel = FoodScreenViewModel(mockGetMealsByCategoryUseCase);
  });

  group('FoodScreenViewModel Tests', () {
    final mealsList = [
      MealsResponseEntity(
        idMeal: '1',
        strMeal: 'Shrimp Pasta',
        strMealThumb: 'thumb1',
      ),
      MealsResponseEntity(
        idMeal: '2',
        strMeal: 'Fish Curry',
        strMealThumb: 'thumb2',
      ),
    ];

    test('Initial state should be default', () {
      expect(viewModel.state.isMealsLoading, false);
      expect(viewModel.state.meals, null);
      expect(viewModel.state.cachedMeals, null);
      expect(viewModel.state.mealsError, null);
    });

    test('GetMealsByCategory success updates meals and cache', () async {
      final successResponse = ApiSuccessResult<List<MealsResponseEntity>>(
        data: mealsList,
      );
      provideDummy<ApiResult<List<MealsResponseEntity>>>(successResponse);

      when(
        mockGetMealsByCategoryUseCase.call('Seafood'),
      ).thenAnswer((_) async => successResponse);

      await viewModel.doIntent(GetMealsByCategoryEvent('Seafood'));

      verify(mockGetMealsByCategoryUseCase.call('Seafood')).called(1);
      expect(viewModel.state.isMealsLoading, false);
      expect(viewModel.state.meals, mealsList);
      expect(viewModel.state.cachedMeals!['Seafood'], mealsList);
      expect(viewModel.state.mealsError, null);
    });

    test('GetMealsByCategory failure updates state with error', () async {
      final errorResponse = ApiErrorResult<List<MealsResponseEntity>>(
        failure: ServerFailure(errorMessage: 'network issue'),
      );
      provideDummy<ApiResult<List<MealsResponseEntity>>>(errorResponse);

      when(
        mockGetMealsByCategoryUseCase.call('Beef'),
      ).thenAnswer((_) async => errorResponse);

      await viewModel.doIntent(GetMealsByCategoryEvent('Beef'));

      verify(mockGetMealsByCategoryUseCase.call('Beef')).called(1);
      expect(viewModel.state.isMealsLoading, false);
      expect(viewModel.state.meals, null);
      expect(viewModel.state.mealsError, 'network issue');
    });

    test('GetMealsByCategory uses cached data when available', () async {
      final cachedMeals = {'Seafood': mealsList};
      viewModel.emit(viewModel.state.copyWith(cachedMeals: cachedMeals));
      await viewModel.doIntent(GetMealsByCategoryEvent('Seafood'));
      verifyNever(mockGetMealsByCategoryUseCase.call('Seafood'));
      expect(viewModel.state.meals, mealsList);
    });
  });
}
