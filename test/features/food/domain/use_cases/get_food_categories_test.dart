import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/food/domain/use_cases/get_food_categories.dart';
import 'package:test/test.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

import '../../../home_screen/domain/use_cases/recommendation_for_you/recommendation_for_you_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo repo;
  late GetFoodCategoriesUseCase useCase;
  late MealsCategoriesEntity mealsCategoriesEntity;

  setUp(() {
    repo = MockHomeRepo();
    useCase = GetFoodCategoriesUseCase(repo);
    mealsCategoriesEntity = MealsCategoriesEntity(
      categoriesDtoEntity: [
        CategoriesDtoEntity(
          idCategory: "1",
          strCategory: "Dessert",
          strCategoryThumb: "dessert.png",
          strCategoryDescription: "Sweet food",
        ),
      ],
    );
  });

  group('GetFoodCategoriesUseCase', () {
    test(
      'should return ApiSuccessResult when repo returns data successfully',
      () async {
        final mockResult = ApiSuccessResult<MealsCategoriesEntity>(
          data: mealsCategoriesEntity,
        );
        provideDummy<ApiResult<MealsCategoriesEntity>>(mockResult);

        when(repo.recommendationForYou()).thenAnswer((_) async => mockResult);

        final result = await useCase.getFoodCategories();

        verify(repo.recommendationForYou()).called(1);

        expect(result, isA<ApiSuccessResult<MealsCategoriesEntity>>());
        result as ApiSuccessResult<MealsCategoriesEntity>;
        expect(result.data.categoriesDtoEntity, isNotNull);
        expect(
          result.data.categoriesDtoEntity.length,
          equals(mealsCategoriesEntity.categoriesDtoEntity.length),
        );
        expect(
          result.data.categoriesDtoEntity.first.strCategory,
          equals(mealsCategoriesEntity.categoriesDtoEntity.first.strCategory),
        );
      },
    );

    test('should return ApiErrorResult when repo returns an error', () async {
      final mockError = ApiErrorResult<MealsCategoriesEntity>(
        failure: Failure(errorMessage: "errorMessage", code: "500"),
      );
      provideDummy<ApiResult<MealsCategoriesEntity>>(mockError);

      when(repo.recommendationForYou()).thenAnswer((_) async => mockError);

      final result = await useCase.getFoodCategories();

      expect(result, isA<ApiErrorResult<MealsCategoriesEntity>>());
      result as ApiErrorResult<MealsCategoriesEntity>;
      expect(result.failure.code, mockError.failure.code);
    });
  });
}
