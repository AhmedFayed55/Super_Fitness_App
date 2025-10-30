import 'package:super_fitness_app/features/details_food/data/models/response/details_food_response_dto.dart';

abstract interface class DetailsFoodDataSource {
  Future<DetailsFoodResponseDto> detailsFoodByIdDataSource(String mealId);
}
