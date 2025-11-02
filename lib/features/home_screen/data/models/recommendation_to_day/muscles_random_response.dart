import 'package:json_annotation/json_annotation.dart';
import 'muscles_dto.dart';

part 'muscles_random_response.g.dart';

@JsonSerializable()
class MusclesRandomResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalMuscles")
  final int? totalMuscles;
  @JsonKey(name: "muscles")
  final List<MusclesDto>? musclesDto;

  MusclesRandomResponse({this.message, this.totalMuscles, this.musclesDto});

  factory MusclesRandomResponse.fromJson(Map<String, dynamic> json) {
    return _$MusclesRandomResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesRandomResponseToJson(this);
  }
}
