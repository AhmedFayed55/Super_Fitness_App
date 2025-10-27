import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/recommendation_for_you/recommendation_for_you_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/recommendation_for_you/recommendation_for_you_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'recommendation_for_you_usecase_test.mocks.dart';

@GenerateMocks([RecommendationForYouRepo])
void main() {
  late MockRecommendationForYouRepo mockRecommendationForYouRepo;
  late RecommendationForYouUseCase recommendationForYouUseCase;
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
    mockRecommendationForYouRepo = MockRecommendationForYouRepo();
    recommendationForYouUseCase = RecommendationForYouUseCase(
      recommendationForYouRepo: mockRecommendationForYouRepo,
    );
  });

  test("success case for recommendationForYouUseCase", () async {
    // Arrange
    var mockResult = ApiSuccessResult<MealsCategoriesEntity>(
      data: mealsCategoriesEntity,
    );
    provideDummy<ApiResult<MealsCategoriesEntity>>(mockResult);

    when(
      mockRecommendationForYouRepo.recommendationForYou(),
    ).thenAnswer((_) async => mockResult);

    // Act
    var result = await recommendationForYouUseCase.call();

    // Assert
    expect(result, isA<ApiSuccessResult<MealsCategoriesEntity>>());
    var successResult = result as ApiSuccessResult<MealsCategoriesEntity>;
    expect(successResult.data.categoriesDtoEntity, isNotEmpty);
    expect(
      successResult.data.categoriesDtoEntity.first.strCategory,
      equals(mealsCategoriesEntity.categoriesDtoEntity.first.strCategory),
    );

    verify(mockRecommendationForYouRepo.recommendationForYou()).called(1);
  });
}
