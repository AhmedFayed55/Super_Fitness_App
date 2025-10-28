import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/recommendation_for_you/recommendation_for_you_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_for_you_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo repo;
  late RecommendationForYouUseCase useCase;
  late MealsCategoriesEntity mealsCategoriesEntity;

  setUp(() {
    mealsCategoriesEntity = MealsCategoriesEntity(
      categoriesDtoEntity: [
        CategoriesDtoEntity(
          idCategory: "idCategory",
          strCategory: "strCategory",
          strCategoryThumb: "strCategoryThumb",
          strCategoryDescription: "strCategoryDescription",
        ),
      ],
    );
    repo = MockHomeRepo();
    useCase = RecommendationForYouUseCase(repo);
  });

  test("success case for recommendationForYouUseCase", () async {
    var mockResult = ApiSuccessResult<MealsCategoriesEntity>(
      data: mealsCategoriesEntity,
    );
    provideDummy<ApiResult<MealsCategoriesEntity>>(mockResult);

    when(repo.recommendationForYou()).thenAnswer((_) async => mockResult);

    var result = await useCase.call();

    verify(repo.recommendationForYou()).called(1);

    expect(result, isA<ApiSuccessResult<MealsCategoriesEntity>>());
    var successResult = result as ApiSuccessResult<MealsCategoriesEntity>;
    expect(successResult.data.categoriesDtoEntity, isNotEmpty);
    expect(
      successResult.data.categoriesDtoEntity.first.strCategory,
      equals(mealsCategoriesEntity.categoriesDtoEntity.first.strCategory),
    );
  });
}
