import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';

class GetUserDataResponseEntity {
  final String message;
  final UserEntity user;

  const GetUserDataResponseEntity({required this.message, required this.user});
}
