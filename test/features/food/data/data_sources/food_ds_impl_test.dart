import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/food/data/data_sources/food_ds_impl.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_response_dto.dart';
import 'package:super_fitness_app/features/food/data/models/meals_response_dto.dart';

import '../../../home_screen/data/data_sources/home_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {

  late MealsApiServices apiServices;
  late FoodDataSourceImpl dataSource;
  late MealsByCategoryResponseDto response;

  setUp(() {
    apiServices = MockMealsApiServices();
    dataSource = FoodDataSourceImpl(apiServices);
    response = MealsByCategoryResponseDto(
      meals: [
        MealsResponseDto(idMeal: "1", strMeal: "Teriyaki Chicken"),
        MealsResponseDto(idMeal: "2", strMeal: "Chicken Alfredo"),
        MealsResponseDto(idMeal: "3", strMeal: "Beef"),
      ]
    );
  });

  group('FoodDataSourceImpl Tests', () {
    test('getMealsByCategory returns MealsByCategoryResponseDto correctly', () async {

      const testCategory = "Chicken";

      when(apiServices.filterMealsByCategory(testCategory))
          .thenAnswer((_) async => response);

      final result = await dataSource.getMealsByCategory(testCategory);

      verify(apiServices.filterMealsByCategory(testCategory)).called(1);

      expect(result, isA<MealsByCategoryResponseDto>());
      expect(result.meals, isA<List<MealsResponseDto>>());
      expect(result.meals, isNotEmpty);
      expect(result.meals?.length, equals(response.meals?.length));
      expect(result.meals?.first.idMeal, equals(response.meals?.first.idMeal));
    });
  });
}