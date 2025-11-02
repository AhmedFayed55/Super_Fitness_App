import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/login/data/models/maper/login_mapers.dart';
import 'package:super_fitness_app/features/auth/login/data/models/request/login_request_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/user_response_dto.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';

void main() {
  group("LoginRequestEntityMapper", () {
    test("should correctly map LoginRequestEntity to LoginRequestDto", () {
      const LoginRequestEntity entity = LoginRequestEntity(
        email: "ahmedfayed@gmail.com",
        password: "123456",
      );

      final LoginRequestDto dto = entity.toDto();

      expect(dto.email, entity.email);
      expect(dto.password, entity.password);
    });
  });

  group("UserResponseDtoMapper", () {
    test(
      "should correctly map UserResponseDto to UserResponseEntity with null values",
      () {
        const UserResponseDto dto = UserResponseDto(
          id: null,
          firstName: null,
          lastName: null,
          email: null,
          gender: null,
          photo: null,
          age: null,
          height: null,
          weight: null,
          goal: null,
          activityLevel: null,
          createdAt: null,
        );

        var entity = dto.toEntity();

        expect(entity.id, null);
        expect(entity.firstName, null);
        expect(entity.lastName, null);
        expect(entity.email, null);
        expect(entity.gender, null);
        expect(entity.photo, null);
        expect(entity.age, null);
        expect(entity.height, null);
        expect(entity.weight, null);
        expect(entity.goal, null);
        expect(entity.activityLevel, null);
        expect(entity.createdAt, null);
      },
    );

    test(
      "should correctly map UserResponseDto to UserResponseEntity with non-null values",
      () {
        const UserResponseDto dto = UserResponseDto(
          id: "514",
          firstName: "Ahmed",
          lastName: "Fayed",
          email: "ahmed@yahoo.com",
          gender: "male",
          photo: "ahmed.png",
          age: 22,
          height: 174,
          weight: 100,
          goal: "70",
          activityLevel: "normal",
          createdAt: "20/10/2025",
        );

        var entity = dto.toEntity();

        expect(entity.id, dto.id);
        expect(entity.firstName, dto.firstName);
        expect(entity.lastName, dto.lastName);
        expect(entity.email, dto.email);
        expect(entity.gender, dto.gender);
        expect(entity.photo, dto.photo);
        expect(entity.age, dto.age);
        expect(entity.height, dto.height);
        expect(entity.weight, dto.weight);
        expect(entity.goal, dto.goal);
        expect(entity.activityLevel, dto.activityLevel);
        expect(entity.createdAt, dto.createdAt);
      },
    );
  });
}
