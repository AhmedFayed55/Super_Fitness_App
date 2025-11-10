import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';

void main() {
  test("Test RegisterResponseModel fromJson", () {
    final json = {
      "message": 'message',
      "user": {
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
        "_id": "id",
        "createdAt": "createdAt",
      },
      "token": 'token',
    };

    final model = RegisterResponseModel.fromJson(json);

    expect(model.message, json['message']);
    expect(model.token, json['token']);

    final user = model.userDto;
    final userJson = json['user'] as Map<String, dynamic>;

    expect(user?.firstName, userJson['firstName']);
    expect(user?.lastName, userJson['lastName']);
    expect(user?.email, userJson['email']);
    expect(user?.gender, userJson['gender']);
    expect(user?.age, userJson['age']);
    expect(user?.weight, userJson['weight']);
    expect(user?.height, userJson['height']);
    expect(user?.activityLevel, userJson['activityLevel']);
    expect(user?.goal, userJson['goal']);
    expect(user?.photo, userJson['photo']);
    expect(user?.id, userJson['_id']);
    expect(user?.createdAt, userJson['createdAt']);
  });



  test("Test RegisterResponseModel toJson", () {
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
    final model = RegisterResponseModel(
      message: 'message',
      userDto: user,
      token: 'token',
    );

    final json = model.toJson();

    expect(json['message'], model.message);
    expect(json['token'], model.token);

    final userJson = model.userDto?.toJson();
    expect(userJson?['firstName'], model.userDto?.firstName);
    expect(userJson?['lastName'], model.userDto?.lastName);
    expect(userJson?['email'], model.userDto?.email);
    expect(userJson?['gender'], model.userDto?.gender);
    expect(userJson?['age'], model.userDto?.age);
    expect(userJson?['weight'], model.userDto?.weight);
    expect(userJson?['height'], model.userDto?.height);
    expect(userJson?['activityLevel'], model.userDto?.activityLevel);
    expect(userJson?['goal'], model.userDto?.goal);
    expect(userJson?['photo'], model.userDto?.photo);
    expect(userJson?['_id'], model.userDto?.id);
    expect(userJson?['createdAt'], model.userDto?.createdAt);
  });

}