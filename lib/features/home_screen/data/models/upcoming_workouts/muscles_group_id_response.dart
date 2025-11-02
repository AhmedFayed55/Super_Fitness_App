import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'muscle_group_dto.dart';

part 'muscles_group_id_response.g.dart';

@JsonSerializable()
class MusclesGroupIdResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "muscleGroup")
  final MuscleGroupDto? muscleGroupDto;
  @JsonKey(name: "muscles")
  final List<MusclesDto>? musclesDto;

  MusclesGroupIdResponse({this.message, this.muscleGroupDto, this.musclesDto});

  factory MusclesGroupIdResponse.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupIdResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupIdResponseToJson(this);
  }
}
