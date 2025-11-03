import 'package:json_annotation/json_annotation.dart';

part 'change_pass_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  ChangePasswordResponse({this.message, this.token});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChangePasswordResponseToJson(this);
  }
}
