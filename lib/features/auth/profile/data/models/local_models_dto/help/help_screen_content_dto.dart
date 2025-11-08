import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/style_dto.dart';

part 'help_screen_content_dto.g.dart';

@JsonSerializable()
class HelpScreenContentDto {
  @JsonKey(name: "section")
  final String? section;
  @JsonKey(name: "content")
  final ContentDto? content;
  @JsonKey(name: "style")
  final StyleDto? style;

  HelpScreenContentDto ({
    this.section,
    this.content,
    this.style,
  });

  factory HelpScreenContentDto.fromJson(Map<String, dynamic> json) {
    return _$HelpScreenContentDtoFromJson(json);
  }

}