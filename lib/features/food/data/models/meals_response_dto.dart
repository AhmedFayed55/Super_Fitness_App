import 'package:json_annotation/json_annotation.dart';

part 'meals_response_dto.g.dart';

@JsonSerializable()
class MealsResponseDto {
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "idMeal")
  final String? idMeal;

  MealsResponseDto({this.strMeal, this.strMealThumb, this.idMeal});

  factory MealsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$MealsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsResponseDtoToJson(this);
  }
}
