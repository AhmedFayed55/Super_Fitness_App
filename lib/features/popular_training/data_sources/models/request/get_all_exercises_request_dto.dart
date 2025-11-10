import 'package:json_annotation/json_annotation.dart';
part 'get_all_exercises_request_dto.g.dart';

@JsonSerializable()
class GetAllExercisesRequestDto {
  final int page;
  final int? limit;

  GetAllExercisesRequestDto({required this.page, this.limit});

  factory GetAllExercisesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllExercisesRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllExercisesRequestDtoToJson(this);
}
