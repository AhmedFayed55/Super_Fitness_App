import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/text_align_dto.dart';

part 'style_dto.g.dart';

@JsonSerializable()
class StyleDto {
  @JsonKey(name: "fontSize")
  final int? fontSize;
  @JsonKey(name: "fontWeight")
  final String? fontWeight;
  @JsonKey(name: "color")
  final String? color;
  @JsonKey(name: "textAlign")
  final TextAlignDto? textAlign;
  @JsonKey(name: "backgroundColor")
  final String? backgroundColor;

  StyleDto ({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory StyleDto.fromJson(Map<String, dynamic> json) {
    return _$StyleDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StyleDtoToJson(this);
  }
}