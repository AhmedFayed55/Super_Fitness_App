import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/user_dto_entity.dart';

void main() {
  late UserDtoEntity userDtoEntity;

  setUp(() {
    userDtoEntity = UserDtoEntity(
      id: "id",
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      gender: "gender",
      age: 1,
      weight: 1,
      height: 1,
      activityLevel: "activityLevel",
      goal: "goal",
      photo: "photo",
      createdAt: "createdAt",
    );
  });

  group("Mapper Tests", () {
    test("UserDtoEntityMapper() toDto", () {
      //Act
      var model = userDtoEntity.toDto();

      //Assert
      expect(model, isA<UserDto>());
      expect(model.id, equals(userDtoEntity.id));
      expect(model.firstName, equals(userDtoEntity.firstName));
      expect(model.lastName, equals(userDtoEntity.lastName));
      expect(model.email, equals(userDtoEntity.email));
      expect(model.gender, equals(userDtoEntity.gender));
      expect(model.age, equals(userDtoEntity.age));
      expect(model.weight, equals(userDtoEntity.weight));
      expect(model.height, equals(userDtoEntity.height));
      expect(model.activityLevel, equals(userDtoEntity.activityLevel));
      expect(model.goal, equals(userDtoEntity.goal));
      expect(model.photo, equals(userDtoEntity.photo));
      expect(model.createdAt, equals(userDtoEntity.createdAt));
    });
    test("RegisterResponseEntityMapper() toModel", () {
      //Arrange
      var entity = RegisterResponseEntity(
        token: "token",
        message: "message",
        userDtoEntity: userDtoEntity,
      );

      //Act
      var model = entity.toModel();

      //Assert
      expect(model, isA<RegisterResponseModel>());
      expect(model.message, equals(entity.message));
      expect(model.token, equals(entity.token));
      expect(model.userDto, isA<UserDto>());
      expect(model.userDto?.id, equals(entity.userDtoEntity?.id));
      expect(model.userDto?.firstName, equals(entity.userDtoEntity?.firstName));
      expect(model.userDto?.lastName, equals(entity.userDtoEntity?.lastName));
      expect(model.userDto?.email, equals(entity.userDtoEntity?.email));
      expect(model.userDto?.gender, equals(entity.userDtoEntity?.gender));
      expect(model.userDto?.age, equals(entity.userDtoEntity?.age));
      expect(model.userDto?.weight, equals(entity.userDtoEntity?.weight));
      expect(model.userDto?.height, equals(entity.userDtoEntity?.height));
      expect(
        model.userDto?.activityLevel,
        equals(entity.userDtoEntity?.activityLevel),
      );
      expect(model.userDto?.goal, equals(entity.userDtoEntity?.goal));
      expect(model.userDto?.photo, equals(entity.userDtoEntity?.photo));
      expect(model.userDto?.createdAt, equals(entity.userDtoEntity?.createdAt));
    });
  });
}
