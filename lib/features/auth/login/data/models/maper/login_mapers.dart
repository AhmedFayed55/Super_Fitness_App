import 'package:super_fitness_app/features/auth/login/data/models/response/user_response_dto.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';

import '../../../domain/entities/request/login_request_entity.dart';
import '../request/login_request_dto.dart';

extension LoginRequestEntityMapper on LoginRequestEntity {
  LoginRequestDto toDto() {
    return LoginRequestDto(email: email, password: password);
  }
}

extension UserResponseDtoMapper on UserResponseDto {
  UserResponseEntity toEntity() {
    return UserResponseEntity(
      gender: gender,
      photo: photo,
      email: email,
      firstName: firstName,
      lastName: lastName,
      id: id,
      createdAt: createdAt,
      activityLevel: activityLevel,
      age: age,
      goal: goal,
      height: height,
      weight: weight,
    );
  }
}
