import 'package:json_annotation/json_annotation.dart';
import 'categories_dto.dart';

part 'meals_categories_response.g.dart';

@JsonSerializable()
class MealsCategoriesResponse {
  @JsonKey(name: "categories")
  final List<CategoriesDto>? categoriesDto;

  MealsCategoriesResponse({this.categoriesDto});

  factory MealsCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsCategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsCategoriesResponseToJson(this);
  }
}
