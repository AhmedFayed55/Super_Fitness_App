import 'package:json_annotation/json_annotation.dart';

part 'text_align_dto.g.dart';

@JsonSerializable()
class TextAlignDto {
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;

  TextAlignDto ({
    this.en,
    this.ar,
  });

  factory TextAlignDto.fromJson(Map<String, dynamic> json) {
    return _$TextAlignDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TextAlignDtoToJson(this);
  }
}