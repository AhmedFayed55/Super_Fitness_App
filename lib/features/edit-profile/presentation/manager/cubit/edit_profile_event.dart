import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';

sealed class EditProfileEvent {}

class EditProfileDataEvent extends EditProfileEvent {}

class LoadUserDataEvent extends EditProfileEvent {
  final UserEntity user;

  LoadUserDataEvent({required this.user});
}

class ChangeActivityEvent extends EditProfileEvent {
  final String activityLevel;

  ChangeActivityEvent({required this.activityLevel});
}

class ChangeGoalEvent extends EditProfileEvent {
  final String goal;

  ChangeGoalEvent({required this.goal});
}

class ChangeWeightEvent extends EditProfileEvent {
  final int weight;

  ChangeWeightEvent({required this.weight});
}

class ChangeFirstNameEvent extends EditProfileEvent {
  final String newFirstName;

  ChangeFirstNameEvent({required this.newFirstName});
}

class ChangeLastNameEvent extends EditProfileEvent {
  final String newLastName;

  ChangeLastNameEvent({required this.newLastName});
}

class ChangeEmailEvent extends EditProfileEvent {
  final String email;

  ChangeEmailEvent({required this.email});
}
