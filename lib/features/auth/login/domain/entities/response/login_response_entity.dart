import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';

class LoginResponseEntity extends Equatable {
  const LoginResponseEntity({this.message, this.user, this.token});

  final String? message;
  final UserResponseEntity? user;
  final String? token;

  @override
  List<Object?> get props => [message, user, token];
}
