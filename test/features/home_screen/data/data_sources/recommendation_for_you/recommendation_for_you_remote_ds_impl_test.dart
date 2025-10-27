import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/recommendation_for_you/recommendation_for_you_remote_ds_impl.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:test/test.dart';

import 'recommendation_for_you_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServicesMeals])
void main() {
  late MockApiServicesMeals mockApiServicesMeals;
  late List<CategoriesDto> listOfCategoriesDto;
  late MealsCategoriesResponse mealsCategoriesResponse;
  late RecommendationForYouRemoteDsImpl recommendationForYouRemoteDsImpl;

  setUp(() {
    listOfCategoriesDto = [
      CategoriesDto(
        idCategory: "idCategory",
        strCategory: "strCategory",
        strCategoryThumb: "strCategoryThumb",
        strCategoryDescription: "strCategoryDescription",
      ),
    ];
    mockApiServicesMeals = MockApiServicesMeals();
    mealsCategoriesResponse = MealsCategoriesResponse(categoriesDto: listOfCategoriesDto);
    recommendationForYouRemoteDsImpl = RecommendationForYouRemoteDsImpl(
      apiServicesMeals: mockApiServicesMeals,
    );
  });

  test(
    "Test RecommendationForYouRemoteDsImpl",
    () async {
      // Arrange
      when(
        mockApiServicesMeals.recommendationForYou(),
      ).thenAnswer((_) async => mealsCategoriesResponse);

      // Act
      final result = await recommendationForYouRemoteDsImpl
          .recommendationForYou();

      // Assert
      expect(result, isA<MealsCategoriesResponse>());
      expect(result.categoriesDto, isNotEmpty);
      expect(
        result.categoriesDto?.first.idCategory,
        equals(listOfCategoriesDto.first.idCategory),
      );
      expect(
        result.categoriesDto?.first.strCategory,
        equals(listOfCategoriesDto.first.strCategory),
      );

      verify(mockApiServicesMeals.recommendationForYou()).called(1);
    },
  );
}
