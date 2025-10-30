import 'package:json_annotation/json_annotation.dart';

part 'ingredient_model_dto.g.dart';

@JsonSerializable()
class IngredientModelDto {
  final String ?name;
  final String ?measure;

  IngredientModelDto({required this.name, required this.measure});

  factory IngredientModelDto.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelDtoToJson(this);
}
