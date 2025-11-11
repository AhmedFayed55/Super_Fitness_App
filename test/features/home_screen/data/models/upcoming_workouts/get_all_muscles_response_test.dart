import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';

void main() {
  group('GetAllMusclesResponse', () {
    test('Test fromJson', () {
      final json = {
        "message": "message",
        "musclesGroup": [
          {"_id": "1", "name": "name 1"},
          {"_id": "2", "name": "name 2"},
        ],
      };

      final response = GetAllMusclesResponse.fromJson(json);

      expect(response.message, "message");
      expect(response.musclesGroupDto?.length, 2);
      expect(response.musclesGroupDto?[0].id, "1");
      expect(response.musclesGroupDto?[0].name, "name 1");
      expect(response.musclesGroupDto?[1].id, "2");
      expect(response.musclesGroupDto?[1].name, "name 2");
    });

    test('Test toJson', () {
      final response = GetAllMusclesResponse(
        message: "message",
        musclesGroupDto: [
          MusclesGroupDto(id: "1", name: "name 1"),
          MusclesGroupDto(id: "2", name: "name 2"),
        ],
      );

      final json = response.toJson();

      expect(json['message'], "message");
      expect((json['musclesGroup'] as List).length, 2);
    });
  });
}
