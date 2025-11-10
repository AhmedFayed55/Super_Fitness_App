import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';

void main() {
  group("Test ChangePasswordResponse", () {
    test("ChangePasswordResponse fromJson", () {
      final json = {"message": "message", "token": "token"};

      final response = ChangePasswordResponse.fromJson(json);

      expect(response.message, equals(json["message"]));
      expect(response.token, equals(json["token"]));
    });

    test("ChangePasswordResponse toJson", () {
      final response = ChangePasswordResponse(
        message: "message",
        token: "token",
      );

      final json = response.toJson();

      expect(json["message"], equals(response.message));
      expect(json["token"], equals(response.token));
    });

    test("ChangePasswordResponse fromJson with null values", () {
      final json = {"message": null, "token": null};

      final response = ChangePasswordResponse.fromJson(json);

      expect(response.message, equals(json["message"]));
      expect(response.token, isNull);
    });
  });
}
