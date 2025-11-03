import 'package:json_annotation/json_annotation.dart';

part 'difficulty_level_dto.g.dart';

@JsonSerializable()
class DifficultyLevelDto {
  String? id;
  String? name;

  DifficultyLevelDto({this.id, this.name});

  factory DifficultyLevelDto.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DifficultyLevelDtoToJson(this);
}
