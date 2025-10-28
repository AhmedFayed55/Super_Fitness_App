import 'package:json_annotation/json_annotation.dart';
import 'meals_response_dto.dart';

part 'meals_by_category_response_dto.g.dart';

@JsonSerializable()
class MealsByCategoryResponseDto {
  @JsonKey(name: "meals")
  final List<MealsResponseDto>? meals;

  MealsByCategoryResponseDto ({
    this.meals,
  });

  factory MealsByCategoryResponseDto.fromJson(Map<String, dynamic> json) {
    return _$MealsByCategoryResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsByCategoryResponseDtoToJson(this);
  }
}




