import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';

sealed class ChangePasswordEvent {}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final ChangePasswordRequest changePasswordRequest;

  ChangePasswordSubmitted({required this.changePasswordRequest});
}

class IsCurrentPasswordVisible extends ChangePasswordEvent {}

class IsNewPasswordVisible extends ChangePasswordEvent {}

class IsConfirmNewPasswordVisible extends ChangePasswordEvent {}
