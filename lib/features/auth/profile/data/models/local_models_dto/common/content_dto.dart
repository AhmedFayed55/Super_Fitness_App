import 'package:json_annotation/json_annotation.dart';

part 'content_dto.g.dart';

@JsonSerializable()
class ContentDto {
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;

  ContentDto ({
    this.en,
    this.ar,
  });

  factory ContentDto.fromJson(Map<String, dynamic> json) {
    return _$ContentDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentDtoToJson(this);
  }
}