import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/logged_user_data/user_data_response_dto.dart';

part 'logged_user_data_response_dto.g.dart';

@JsonSerializable()
class LoggedUserDataResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDataResponseDto? user;

  LoggedUserDataResponseDto({this.message, this.user});

  factory LoggedUserDataResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LoggedUserDataResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoggedUserDataResponseDtoToJson(this);
  }
}
