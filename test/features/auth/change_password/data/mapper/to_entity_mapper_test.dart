import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/change_password/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';

void main() {
  group("Test ChangePasswordResponseMapper", () {
    test("ChangePasswordResponseMapper convert from response to Entity", () {
      /// Arrange
      final response = ChangePasswordResponse(
        message: 'Success',
        token: 'token',
      );

      /// Act
      final entity = response.toEntity();

      /// Assert
      expect(entity, isA<ChangePasswordEntity>());
      expect(entity.message, equals(response.message));
      expect(entity.token, equals(response.token));
    });

    test('ChangePasswordResponse return null', () {
      /// Arrange & Act
      final response = ChangePasswordResponse(message: null, token: null);

      /// Act
      final entity = response.toEntity();

      /// Assert
      expect(entity.message, equals(''));
      expect(entity.token, equals(''));
    });
  });
}
