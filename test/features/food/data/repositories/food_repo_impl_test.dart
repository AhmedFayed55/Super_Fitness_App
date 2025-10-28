import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/food/data/data_sources/food_ds.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_response_dto.dart';
import 'package:super_fitness_app/features/food/data/models/meals_response_dto.dart';
import 'package:super_fitness_app/features/food/data/repositories/food_repo_impl.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';

import 'food_repo_impl_test.mocks.dart';

@GenerateMocks([FoodDataSource])
void main() {
  late FoodDataSource dataSource;
  late FoodRepoImpl repo;
  late MealsByCategoryResponseDto responseDto;

  setUp(() {
    dataSource = MockFoodDataSource();
    repo = FoodRepoImpl(dataSource);

    responseDto = MealsByCategoryResponseDto(
      meals: [
        MealsResponseDto(
          idMeal: '1',
          strMeal: 'Chicken',
          strMealThumb: 'hen.png',
        ),
        MealsResponseDto(
          idMeal: '2',
          strMeal: 'Beef',
          strMealThumb: 'cow.png',
        ),
      ],
    );
  });

  group('FoodRepoImpl', () {
    group('getMealsByCategory', () {
      const categoryName = 'Beef';

      test('should return ApiSuccessResult when successful', () async {

        when(dataSource.getMealsByCategory(categoryName))
            .thenAnswer((_) async => responseDto);

        final result = await repo.getMealsByCategory(categoryName);

        verify(dataSource.getMealsByCategory(categoryName)).called(1);

        expect(result, isA<ApiSuccessResult<List<MealsResponseEntity>>>());
        result as ApiSuccessResult<List<MealsResponseEntity>>;
        expect(result.data, isNotNull);
        expect(result.data.length, equals(responseDto.meals?.length));
        expect(result.data.first.idMeal, equals(responseDto.meals?.first.idMeal));
      });

      test('should return ApiSuccessResult with empty list when meals is null', () async {
        when(dataSource.getMealsByCategory(categoryName))
            .thenAnswer((_) async => MealsByCategoryResponseDto(meals: null));

        final result = await repo.getMealsByCategory(categoryName);

        expect(result, isA<ApiSuccessResult<List<MealsResponseEntity>>>());
        result as ApiSuccessResult<List<MealsResponseEntity>>;
        expect(result.data, isEmpty);
      });

      test('should return ApiErrorResult on DioException', () async {
        when(dataSource.getMealsByCategory(categoryName))
            .thenThrow(DioException(requestOptions: RequestOptions()));

        final result = await repo.getMealsByCategory(categoryName);

        expect(result, isA<ApiErrorResult<List<MealsResponseEntity>>>());
        result as ApiErrorResult<List<MealsResponseEntity>>;
        expect(result.failure, isA<ServerFailure>());
      });

      test('should return ApiErrorResult on generic Exception', () async {
        when(dataSource.getMealsByCategory(categoryName))
            .thenThrow(Exception('Unexpected error'));

        final result = await repo.getMealsByCategory(categoryName);

        expect(result, isA<ApiErrorResult<List<MealsResponseEntity>>>());
        result as ApiErrorResult<List<MealsResponseEntity>>;
        expect(result.failure, isA<Failure>());
      });
    });
  });
}
