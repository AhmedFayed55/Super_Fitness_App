import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';

sealed class RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {
  final RegisterRequestModel registerRequestModel;

  SubmitRegisterEvent({required this.registerRequestModel});
}
