import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/style_dto.dart';
part 'security_roles_screen_response_dto.g.dart';

@JsonSerializable()
class SecurityRolesConfigResponseDto {
  @JsonKey(name: "section")
  final String? section;
  @JsonKey(name: "content")
  final ContentDto? content;
  @JsonKey(name: "style")
  final StyleDto? style;

  SecurityRolesConfigResponseDto ({
    this.section,
    this.content,
    this.style,
  });

  factory SecurityRolesConfigResponseDto.fromJson(Map<String, dynamic> json) {
    return _$SecurityRolesConfigResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SecurityRolesConfigResponseDtoToJson(this);
  }
}



