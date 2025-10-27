import 'package:dio/dio.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/recommendation_for_you/recommendation_for_you_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/repositories_impl/recommendation_for_you/recommendation_for_you_repo_impl.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'recommendation_for_you_repo_impl_test.mocks.dart';

@GenerateMocks([RecommendationForYouRemoteDs])
void main() {
  late MockRecommendationForYouRemoteDs mockRecommendationForYouRemoteDs;
  late RecommendationForYouRepoImpl recommendationForYouRepoImpl;
  late MealsCategoriesResponse mealsCategoriesResponse;
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
    mealsCategoriesResponse = MealsCategoriesResponse(
      categoriesDto: [
        CategoriesDto(
          idCategory: "idCategory",
          strCategory: "strCategory",
          strCategoryThumb: "strCategoryThumb",
          strCategoryDescription: "strCategoryDescription",
        ),
      ],
    );
    mockRecommendationForYouRemoteDs = MockRecommendationForYouRemoteDs();
    recommendationForYouRepoImpl = RecommendationForYouRepoImpl(
      recommendationForYouRemoteDs: mockRecommendationForYouRemoteDs,
    );
  });

  group("Test RecommendationForYouRepoImpl", () {
    test("success case with ApiSuccessResult", () async {
      // Arrange
      when(
        mockRecommendationForYouRemoteDs.recommendationForYou(),
      ).thenAnswer((_) async => mealsCategoriesResponse);

      // Act
      var result = await recommendationForYouRepoImpl.recommendationForYou();

      // Assert
      expect(result, isA<ApiSuccessResult<MealsCategoriesEntity>>());
      var successResult = result as ApiSuccessResult<MealsCategoriesEntity>;
      expect(successResult.data.categoriesDtoEntity, isNotEmpty);
      expect(
        successResult.data.categoriesDtoEntity.first.strCategory,
        equals(mealsCategoriesEntity.categoriesDtoEntity.first.strCategory),
      );

      verify(mockRecommendationForYouRemoteDs.recommendationForYou()).called(1);
    });

    test("Error case with DioException", () async {
      // Arrange
      final dioException = DioException(requestOptions: RequestOptions());
      when(
        mockRecommendationForYouRemoteDs.recommendationForYou(),
      ).thenThrow(dioException);

      // Act
      var result = await recommendationForYouRepoImpl.recommendationForYou();

      // Assert
      expect(result, isA<ApiErrorResult<MealsCategoriesEntity>>());
      var errorResult = result as ApiErrorResult<MealsCategoriesEntity>;
      expect(errorResult.failure, isA<ServerFailure>());
      expect(errorResult.failure, isNotNull);

      verify(mockRecommendationForYouRemoteDs.recommendationForYou()).called(1);
    });

    test("Error case with generic Exception", () async {
      // Arrange
      String errorMessage = "errorMessage";
      final exception = Exception(errorMessage);
      when(
        mockRecommendationForYouRemoteDs.recommendationForYou(),
      ).thenThrow(exception);

      // Act
      var result = await recommendationForYouRepoImpl.recommendationForYou();

      // Assert
      expect(result, isA<ApiErrorResult<MealsCategoriesEntity>>());
      var errorResult = result as ApiErrorResult<MealsCategoriesEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure, isNotNull);

      verify(mockRecommendationForYouRemoteDs.recommendationForYou()).called(1);
    });
  });
}
