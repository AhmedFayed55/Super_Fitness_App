import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? userDto;
  @JsonKey(name: "token")
  final String? token;

  RegisterResponseModel({this.message, this.userDto, this.token});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterResponseModelToJson(this);
  }
}
