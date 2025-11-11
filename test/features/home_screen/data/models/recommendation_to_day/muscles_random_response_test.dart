import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';

void main() {
  group('MusclesRandomResponse', () {
    test('Test fromJson', () {
      final json = {
        "message": "message",
        "totalMuscles": 2,
        "muscles": [
          {"id": 1, "name": "name 1"},
          {"id": 2, "name": "name 2"},
        ]
      };

      final result = MusclesRandomResponse.fromJson(json);

      expect(result.message, "message");
      expect(result.totalMuscles, 2);
      expect(result.musclesDto, isA<List<MusclesDto>>());
      expect(result.musclesDto!.length, 2);
      expect(result.musclesDto![0].name, "name 1");
      expect(result.musclesDto![1].name, "name 2");
    });

    test('Test toJson', () {
      final response = MusclesRandomResponse(
        message: "message",
        totalMuscles: 1,
        musclesDto: [
          MusclesDto(id: "id", name: "name"),
        ],
      );

      final json = response.toJson();

      expect(json["message"], "message");
      expect(json["totalMuscles"], 1);

      final musclesList = json["muscles"];
      expect(musclesList, isA<List>());
      expect(musclesList.first.toJson()["name"], "name");
    });
  });
}
