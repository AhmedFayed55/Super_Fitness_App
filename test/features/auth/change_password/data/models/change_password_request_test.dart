import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';

void main() {
  group("Test ChangePasswordRequest", () {
    test("Test ChangePasswordRequest fromJson", () {
      /// Arrange
      final json = {"password": "password", "newPassword": "newPassword"};

      /// Act
      var result = ChangePasswordRequest.fromJson(json);

      /// Assert
      expect(result.password, equals(json["password"]));
      expect(result.newPassword, equals(json["newPassword"]));
    });

    test("Test ChangePasswordRequest toJson", () {
      /// Arrange
      final response = ChangePasswordRequest(
        password: "password",
        newPassword: "newPassword",
      );

      /// Act
      var json = response.toJson();

      /// Assert
      expect(json["password"], equals(response.password));
      expect(json["newPassword"], equals(response.newPassword));
    });

    test("Test ChangePasswordRequest fromJson with null values", () {
      /// Arrange
      final json = {"password": null, "newPassword": null};

      /// Act
      var result = ChangePasswordRequest.fromJson(json);

      /// Assert
      expect(result.password, isNull);
      expect(result.newPassword, isNull);
    });
  });
}
