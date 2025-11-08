import 'package:super_fitness_app/features/edit-profile/data/model/edit_user_respone/user.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';

extension ToDto on UserEntity {
  User toDto() {
    return User(
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
    );
  }
}
