import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/user_dto_entity.dart';

class RegisterResponseEntity {
  final String? message;
  final UserDtoEntity? userDtoEntity;
  final String? token;

  RegisterResponseEntity({this.message, this.userDtoEntity, this.token});
}
