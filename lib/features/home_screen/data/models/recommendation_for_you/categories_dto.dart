import 'package:json_annotation/json_annotation.dart';

part 'categories_dto.g.dart';

@JsonSerializable()
class CategoriesDto {
  @JsonKey(name: "idCategory")
  final String? idCategory;
  @JsonKey(name: "strCategory")
  final String? strCategory;
  @JsonKey(name: "strCategoryThumb")
  final String? strCategoryThumb;
  @JsonKey(name: "strCategoryDescription")
  final String? strCategoryDescription;

  CategoriesDto({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory CategoriesDto.fromJson(Map<String, dynamic> json) {
    return _$CategoriesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesDtoToJson(this);
  }
}
