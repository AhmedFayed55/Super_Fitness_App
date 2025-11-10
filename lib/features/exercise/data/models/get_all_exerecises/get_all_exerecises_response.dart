import 'package:json_annotation/json_annotation.dart';

import 'exercise_dto.dart';

part 'get_all_exerecises_response.g.dart';

@JsonSerializable()
class GetAllExerecisesResponse {
  String? message;
  int? totalExercises;
  int? totalPages;
  int? currentPage;
  List<ExerciseDto>? exercises;

  GetAllExerecisesResponse({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory GetAllExerecisesResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAllExerecisesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllExerecisesResponseToJson(this);
}
