import 'package:json_annotation/json_annotation.dart';
import 'muscles_group_dto.dart';

part 'get_all_muscles_response.g.dart';

@JsonSerializable()
class GetAllMusclesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroupDto>? musclesGroupDto;

  GetAllMusclesResponse({this.message, this.musclesGroupDto});

  factory GetAllMusclesResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAllMusclesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllMusclesResponseToJson(this);
  }
}
