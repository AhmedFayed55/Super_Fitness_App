import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/details_food/data/data_source/details_food_ds_imp.dart';
import 'package:super_fitness_app/features/details_food/data/models/response/details_food_response_dto.dart';
import 'package:super_fitness_app/features/details_food/data/models/response/meal_model_dto.dart';

import '../../../home_screen/data/data_sources/home_ds_impl_test.mocks.dart';

@GenerateMocks([MealsApiServices])
void main() {
  group('test Details food Data Source', () {
    test(
      'verify when call details food data source is should call detailsFoodById from api service meal',
      () async {
        var mockApiServiceMeal = MockMealsApiServices();
        var data = DetailsFoodDataSourceImp(mockApiServiceMeal);
        var mockResponseDto = DetailsFoodResponseDto(meals: [MealModelDto()]);
        when(
          mockApiServiceMeal.detailsFoodById(''),
        ).thenAnswer((_) async => mockResponseDto);
        var result = await data.detailsFoodByIdDataSource('');
        verify(mockApiServiceMeal.detailsFoodById('')).called(1);
        expect(result, isA<DetailsFoodResponseDto>());
        expect(result.meals, isNotEmpty);
      },
    );
  });
}
