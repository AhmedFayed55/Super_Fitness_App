import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/edit-profile/data/mapper/to_dto.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';

void main() {
  group('UserEntity toDto()', () {
    test('should convert UserEntity to User DTO correctly', () {
      // Arrange
      final entity = UserEntity(
        id: '123',
        firstName: 'Ahmed',
        lastName: 'Yehia',
        email: 'test@test.com',
        gender: 'male',
        age: 22,
        weight: 70,
        height: 180,
        activityLevel: 'Intermediate',
        goal: 'Gain Weight',
        photo: 'photo_url_here',
        createdAt: DateTime.now(),
      );

      // Act
      final dtoUser = entity.toDto();

      // Assert
      expect(dtoUser.id, entity.id);
      expect(dtoUser.firstName, entity.firstName);
      expect(dtoUser.lastName, entity.lastName);
      expect(dtoUser.email, entity.email);
      expect(dtoUser.gender, entity.gender);
      expect(dtoUser.age, entity.age);
      expect(dtoUser.weight, entity.weight);
      expect(dtoUser.height, entity.height);
      expect(dtoUser.activityLevel, entity.activityLevel);
      expect(dtoUser.goal, entity.goal);
      expect(dtoUser.photo, entity.photo);
    });
  });
}
