import 'package:json_annotation/json_annotation.dart';

import 'difficulty_level_dto.dart';

part 'get_difficulty_level_respone.g.dart';

@JsonSerializable()
class GetDifficultyLevelRespone {
  String? message;
  int? totalLevels;
  @JsonKey(name: 'difficulty_levels')
  List<DifficultyLevelDto>? difficultyLevels;

  GetDifficultyLevelRespone({
    this.message,
    this.totalLevels,
    this.difficultyLevels,
  });

  factory GetDifficultyLevelRespone.fromJson(Map<String, dynamic> json) {
    return _$GetDifficultyLevelResponeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetDifficultyLevelResponeToJson(this);
}
