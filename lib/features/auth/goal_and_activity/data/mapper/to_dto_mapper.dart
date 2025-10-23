import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/user_dto_entity.dart';

extension UserDtoEntityMapper on UserDtoEntity {
  UserDto toDto() {
    return UserDto(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      photo: photo,
      createdAt: createdAt,
    );
  }
}

extension RegisterResponseEntityMapper on RegisterResponseEntity {
  RegisterResponseModel toModel() {
    return RegisterResponseModel(
      message: message,
      token: token,
      userDto: userDtoEntity?.toDto(),
    );
  }
}
