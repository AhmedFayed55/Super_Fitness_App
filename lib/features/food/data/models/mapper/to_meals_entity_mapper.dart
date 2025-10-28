import 'package:super_fitness_app/features/food/data/models/meals_response_dto.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';

extension MealsMapper on MealsResponseDto{
  MealsResponseEntity toEntity() =>
      MealsResponseEntity(
          strMeal: strMeal ?? "",
          strMealThumb: strMealThumb ?? "",
          idMeal: idMeal ?? ""
      );
}