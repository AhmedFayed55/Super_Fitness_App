import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/user_dto.dart';

part 'get_user_data_response_dto.g.dart';

@JsonSerializable()
class GetUserDataResponseDto {
  final String? message;
  final UserDto? user;

  GetUserDataResponseDto({this.message, this.user});

  factory GetUserDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetUserDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserDataResponseDtoToJson(this);
}
