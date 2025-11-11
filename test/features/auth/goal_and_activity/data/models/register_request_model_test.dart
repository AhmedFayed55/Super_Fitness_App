import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';

void main() {
  test("Test RegisterRequestModel toJson", () {
    final model = RegisterRequestModel(
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      password: "password",
      rePassword: "rePassword",
      gender: "gender",
      height: 1,
      weight: 1,
      age: 1,
      goal: "goal",
      activityLevel: "activityLevel",
    );

    final json = model.toJson();

    expect(json['firstName'], model.firstName);
    expect(json['lastName'], model.lastName);
    expect(json['email'], model.email);
    expect(json['password'], model.password);
    expect(json['rePassword'], model.rePassword);
    expect(json['gender'], model.gender);
    expect(json['height'], model.height);
    expect(json['weight'], model.weight);
    expect(json['age'], model.age);
    expect(json['goal'], model.goal);
    expect(json['activityLevel'], model.activityLevel);
  });
}
