import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/logged_user_data/user_data_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/mapper/user_data.dart';

void main() {
  group('UserDataResponseDtoMapper', () {
    test('toEntity converts all fields correctly when all values provided', () {
      final dto = UserDataResponseDto(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        gender: 'male',
        createdAt: '2025-11-10',
        activityLevel: 'medium',
        height: 180,
        weight: 120,
        goal: 'lose weight',
        age: 30,
        photo: 'photo_url',
      );

      final entity = dto.toEntity();

      expect(entity, isA<UserDataResponseEntity>());
      expect(entity.id, dto.id);
      expect(entity.firstName, dto.firstName);
      expect(entity.lastName, dto.lastName);
      expect(entity.email, dto.email);
      expect(entity.gender, dto.gender);
      expect(entity.createdAt, dto.createdAt);
      expect(entity.activityLevel, dto.activityLevel);
      expect(entity.height, dto.height);
      expect(entity.weight, dto.weight);
      expect(entity.goal, dto.goal);
      expect(entity.age, dto.age);
      expect(entity.photo, dto.photo);
    });

    test('toEntity assigns default values when optional fields are null', () {
      final dto = UserDataResponseDto(
        id: '2',
        email: 'jane@example.com',
        firstName: null,
        lastName: null,
        gender: null,
        createdAt: null,
        activityLevel: null,
        height: null,
        weight: null,
        goal: null,
        age: null,
        photo: null,
      );

      final entity = dto.toEntity();

      expect(entity.firstName, 'Unknown');
      expect(entity.lastName, 'Unknown');
      expect(entity.gender, 'unspecified');
      expect(entity.createdAt, '');
      expect(entity.activityLevel, 'low');
      expect(entity.height, 0);
      expect(entity.weight, 0);
      expect(entity.goal, '');
      expect(entity.age, 0);
      expect(entity.photo, '');
    });

    test('toEntity throws Exception when id is null', () {
      final dto = UserDataResponseDto(
        id: null,
        email: 'test@example.com',
      );

      expect(() => dto.toEntity(), throwsA(isA<Exception>()));
    });

    test('toEntity throws Exception when email is null', () {
      final dto = UserDataResponseDto(
        id: '1',
        email: null,
      );

      expect(() => dto.toEntity(), throwsA(isA<Exception>()));
    });
  });
}
