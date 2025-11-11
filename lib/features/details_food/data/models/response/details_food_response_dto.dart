import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/details_food/data/models/response/meal_model_dto.dart';

part 'details_food_response_dto.g.dart';

@JsonSerializable()
class DetailsFoodResponseDto {
  final List<MealModelDto> meals;

  DetailsFoodResponseDto({required this.meals});

  factory DetailsFoodResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DetailsFoodResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsFoodResponseDtoToJson(this);
}
