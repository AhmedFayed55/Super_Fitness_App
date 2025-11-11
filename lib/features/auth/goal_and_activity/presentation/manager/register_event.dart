sealed class RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {
  final String activityLevel;

  SubmitRegisterEvent({required this.activityLevel});
}

class OnSelectedGoalEvent extends RegisterEvent {
  final String? goal;

  OnSelectedGoalEvent({required this.goal});
}

class OnSelectedActivityEvent extends RegisterEvent {
  final String? activity;

  OnSelectedActivityEvent({required this.activity});
}

class SaveAgeEvent extends RegisterEvent {
  final int age;

  SaveAgeEvent(this.age);
}

class SaveWeightEvent extends RegisterEvent {
  final int weight;

  SaveWeightEvent(this.weight);
}

class SaveHeightEvent extends RegisterEvent {
  final int height;

  SaveHeightEvent(this.height);
}

class SaveGenderEvent extends RegisterEvent {
  final String gender;

  SaveGenderEvent(this.gender);
}
