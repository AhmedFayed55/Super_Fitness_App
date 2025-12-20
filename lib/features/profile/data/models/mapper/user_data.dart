import 'package:super_fitness_app/features/profile/data/models/logged_user_data/user_data_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';

extension UserDataResponseDtoMapper on UserDataResponseDto {
  UserDataResponseEntity toEntity() {
    if (id == null || email == null) {
      throw Exception("Missing essential user data");
    }

    return UserDataResponseEntity(
      id: id!,
      firstName: firstName ?? "Unknown",
      gender: gender ?? "unspecified",
      createdAt: createdAt ?? "",
      activityLevel: activityLevel ?? "low",
      height: height ?? 0,
      weight: weight ?? 0,
      goal: goal ?? "",
      age: age ?? 0,
      lastName: lastName ?? "Unknown",
      email: email!,
      photo: photo ?? "",
    );
  }
}
