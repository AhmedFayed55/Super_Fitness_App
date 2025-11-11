import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';

void main() {
  group('MusclesGroupIdResponse', () {
    test('Test fromJson', () {
      final json = {
        "message": "message",
        "muscleGroup": {"_id": "id", "name": "name"},
        "muscles": [
          {
            "_id": "id 1",
            "name": "name 1",
            "image": "image 1",
          },
          {
            "_id": "id 2",
            "name": "name 2",
            "image": "image 2",
          },
        ],
      };

      final response = MusclesGroupIdResponse.fromJson(json);

      expect(response.message, "message");

      expect(response.muscleGroupDto?.id, "id");
      expect(response.muscleGroupDto?.name, "name");

      expect(response.musclesDto?.length, 2);
      expect(response.musclesDto?[0].id, "id 1");
      expect(response.musclesDto?[0].name, "name 1");
      expect(response.musclesDto?[0].image, "image 1");
      expect(response.musclesDto?[1].id, "id 2");
      expect(response.musclesDto?[1].name, "name 2");
      expect(response.musclesDto?[1].image, "image 2");
    });

    test('Test toJson', () {
      final response = MusclesGroupIdResponse(
        muscleGroupDto: MuscleGroupDto(id: "id", name: "name"),
        musclesDto: [
          MusclesDto(
            id: "id",
            name: "name",
            image: "image",
          ),
          MusclesDto(
            id: "id",
            name: "name",
            image: "image",
          ),
        ],
      );

      final json = response.toJson();
      expect((json['muscles'] as List).length, 2);
    });
  });
}
