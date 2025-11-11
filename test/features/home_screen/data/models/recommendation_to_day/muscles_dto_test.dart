import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';

void main() {
  group('MusclesDto', () {
    test('Test fromJson', () {
      final json = {"_id": "1", "name": "name", "image": "image"};

      final model = MusclesDto.fromJson(json);

      expect(model.id, "1");
      expect(model.name, "name");
      expect(model.image, "image");
    });

    test('Test toJson', () {
      final model = MusclesDto(id: "1", name: "name", image: "image");

      final json = model.toJson();

      expect(json["_id"], model.id);
      expect(json["name"], model.name);
      expect(json["image"], model.image);
    });
  });
}
