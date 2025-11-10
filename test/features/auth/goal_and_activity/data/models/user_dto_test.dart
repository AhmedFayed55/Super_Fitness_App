import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';

void main() {
  test("Test UserDto fromJson", () {
    final json = {
      "firstName": "firstName",
      "lastName": "lastName",
      "email": "email",
      "gender": "gender",
      "age": 1,
      "weight": 1,
      "height": 1,
      "activityLevel": "activityLevel",
      "goal": "goal",
      "photo": "photo",
      "id": "id",
      "createdAt": "createdAt",
    };

    final user = UserDto.fromJson(json);

    expect(user.firstName, user.firstName);
    expect(user.lastName, user.lastName);
    expect(user.email, user.email);
    expect(user.gender, user.gender);
    expect(user.age, user.age);
    expect(user.weight, user.weight);
    expect(user.height, user.height);
    expect(user.activityLevel, user.activityLevel);
    expect(user.goal, user.goal);
    expect(user.photo, user.photo);
    expect(user.id, user.id);
    expect(user.createdAt, user.createdAt);
  });

  test("Test UserDto toJson", () {
    final user = UserDto(
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      gender: "gender",
      age: 1,
      weight: 1,
      height: 1,
      activityLevel: "activityLevel",
      goal: "goal",
      photo: "photo",
      id: "id",
      createdAt: "createdAt",
    );

    final json = user.toJson();

    expect(json['firstName'], user.firstName);
    expect(json['lastName'], user.lastName);
    expect(json['email'], user.email);
    expect(json['gender'], user.gender);
    expect(json['age'], user.age);
    expect(json['weight'], user.weight);
    expect(json['height'], user.height);
    expect(json['activityLevel'], user.activityLevel);
    expect(json['goal'], user.goal);
    expect(json['photo'], user.photo);
    expect(json['_id'], user.id);
    expect(json['createdAt'], user.createdAt);
  });
}
