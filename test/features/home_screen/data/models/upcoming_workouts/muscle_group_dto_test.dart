import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';

void main() {
  group('MuscleGroupDto', () {
    test('Test fromJson', () {
      final json = {"_id": "id", "name": "name"};

      final dto = MuscleGroupDto.fromJson(json);

      expect(dto.id, "id");
      expect(dto.name, "name");
    });

    test('Test toJson', () {
      final dto = MuscleGroupDto(id: "id", name: "name");

      final json = dto.toJson();

      expect(json["_id"], "id");
      expect(json["name"], "name");
    });
  });
}
