import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/user_dto_entity.dart';

void main() {
  late UserDto userDto;

  setUp(() {
    userDto = UserDto(
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
    test("UserDtoToEntityMapper() toEntity", () {
      //Act
      var entity = userDto.toEntity();

      //Assert
      expect(entity, isA<UserDtoEntity>());
      expect(entity.id, equals(userDto.id));
      expect(entity.firstName, equals(userDto.firstName));
      expect(entity.lastName, equals(userDto.lastName));
      expect(entity.email, equals(userDto.email));
      expect(entity.gender, equals(userDto.gender));
      expect(entity.age, equals(userDto.age));
      expect(entity.weight, equals(userDto.weight));
      expect(entity.height, equals(userDto.height));
      expect(entity.activityLevel, equals(userDto.activityLevel));
      expect(entity.goal, equals(userDto.goal));
      expect(entity.photo, equals(userDto.photo));
      expect(entity.createdAt, equals(userDto.createdAt));
    });
    test("RegisterResponseModelMapper() ToEntity", () {
      //Arrange
      var model = RegisterResponseModel(
        token: "token",
        message: "message",
        userDto: userDto,
      );

      //Act
      var entity = model.toEntity();

      //Assert
      expect(entity, isA<RegisterResponseEntity>());
      expect(entity.message, equals(model.message));
      expect(entity.token, equals(model.token));
      expect(entity.userDtoEntity, isA<UserDtoEntity>());
      expect(entity.userDtoEntity?.id, equals(userDto.id));
      expect(entity.userDtoEntity?.firstName, equals(userDto.firstName));
      expect(entity.userDtoEntity?.lastName, equals(userDto.lastName));
      expect(entity.userDtoEntity?.email, equals(userDto.email));
      expect(entity.userDtoEntity?.gender, equals(userDto.gender));
      expect(entity.userDtoEntity?.age, equals(userDto.age));
      expect(entity.userDtoEntity?.weight, equals(userDto.weight));
      expect(entity.userDtoEntity?.height, equals(userDto.height));
      expect(
        entity.userDtoEntity?.activityLevel,
        equals(userDto.activityLevel),
      );
      expect(entity.userDtoEntity?.goal, equals(userDto.goal));
      expect(entity.userDtoEntity?.photo, equals(userDto.photo));
      expect(entity.userDtoEntity?.createdAt, equals(userDto.createdAt));
    });
  });
}
