sealed class RegisterEvent {}

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
