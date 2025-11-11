import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/details_food/data/data_source/details_food_ds.dart';
import 'package:super_fitness_app/features/details_food/data/models/response/details_food_response_dto.dart';

@Injectable(as: DetailsFoodDataSource)
class DetailsFoodDataSourceImp implements DetailsFoodDataSource {
  final MealsApiServices _mealsApiServices;
  DetailsFoodDataSourceImp(this._mealsApiServices);
  @override
  Future<DetailsFoodResponseDto> detailsFoodByIdDataSource(String mealId) {
    return _mealsApiServices.detailsFoodById(mealId);
  }
}
