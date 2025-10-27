import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_dto.g.dart';

@JsonSerializable()
class MuscleGroupDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MuscleGroupDto({this.id, this.name});

  factory MuscleGroupDto.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupDtoToJson(this);
  }
}
