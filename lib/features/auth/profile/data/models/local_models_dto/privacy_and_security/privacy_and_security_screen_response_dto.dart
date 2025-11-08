import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/style_dto.dart';

part 'privacy_and_security_screen_response_dto.g.dart';

@JsonSerializable()
class PrivacyAndSecurityScreenResponseDto {
  @JsonKey(name: "section")
  final String? section;
  @JsonKey(name: "content")
  final ContentDto? content;
  @JsonKey(name: "style")
  final StyleDto? style;

  PrivacyAndSecurityScreenResponseDto ({
    this.section,
    this.content,
    this.style,
  });

  factory PrivacyAndSecurityScreenResponseDto.fromJson(Map<String, dynamic> json) {
    return _$PrivacyAndSecurityScreenResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PrivacyAndSecurityScreenResponseDtoToJson(this);
  }
}



