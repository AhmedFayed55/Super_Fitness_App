import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/food/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:test/test.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'package:super_fitness_app/features/food/domain/repositories/food_repo.dart';

import 'get_meals_by_category_use_case_test.mocks.dart';

@GenerateMocks([FoodRepo])
void main() {
  late FoodRepo repo;
  late GetMealsByCategoryUseCase useCase;
  late List<MealsResponseEntity> mealsList;

  setUp(() {
    repo = MockFoodRepo();
    useCase = GetMealsByCategoryUseCase(repo);
    mealsList = [
      MealsResponseEntity(
        idMeal: '1',
        strMeal: 'pizza',
        strMealThumb: 'pizza.png',
      ),
      MealsResponseEntity(
        idMeal: '2',
        strMeal: 'shawerma',
        strMealThumb: 'shawerma.png',
      ),
    ];
  });

  group('GetMealsByCategoryUseCase', () {
    const categoryName = 'Beef';

    test(
      'should return ApiSuccessResult when repo returns data successfully',
      () async {
        final mockResult = ApiSuccessResult<List<MealsResponseEntity>>(
          data: mealsList,
        );
        provideDummy<ApiResult<List<MealsResponseEntity>>>(mockResult);

        when(
          repo.getMealsByCategory(categoryName),
        ).thenAnswer((_) async => mockResult);

        final result = await useCase.call(categoryName);

        verify(repo.getMealsByCategory(categoryName)).called(1);

        expect(result, isA<ApiSuccessResult<List<MealsResponseEntity>>>());
        result as ApiSuccessResult<List<MealsResponseEntity>>;
        expect(result.data.length, mealsList.length);
        expect(result.data, isNotEmpty);
        expect(result.data.first.idMeal, equals(mealsList.first.idMeal));
      },
    );

    test('should return ApiErrorResult when repo throws error', () async {
      final mockError = ApiErrorResult<List<MealsResponseEntity>>(
        failure: Failure(errorMessage: "errorMessage"),
      );
      provideDummy<ApiResult<List<MealsResponseEntity>>>(mockError);

      when(
        repo.getMealsByCategory(categoryName),
      ).thenAnswer((_) async => mockError);

      final result = await useCase.call(categoryName);

      expect(result, isA<ApiErrorResult<List<MealsResponseEntity>>>());
      result as ApiErrorResult<List<MealsResponseEntity>>;
      expect(
        result.failure.errorMessage,
        equals(mockError.failure.errorMessage),
      );
    });
  });
}
