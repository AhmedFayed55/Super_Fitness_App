import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/user_response_dto.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto{
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserResponseDto? user;
  @JsonKey(name: "token")
  final String? token;

  const LoginResponseDto({this.message, this.user, this.token});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseDtoToJson(this);
  }

}
