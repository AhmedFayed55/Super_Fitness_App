import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/change_password/data/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';

void main() {
  test("ChangePasswordEntityMapper convert from Entity to Dto", () {
    /// Arrange
    final entity = ChangePasswordEntity(message: 'Success', token: 'token');

    /// Act
    final dto = entity.toDto();

    /// Assert
    expect(dto, isA<ChangePasswordResponse>());
    expect(dto.message, equals(entity.message));
    expect(dto.token, equals(entity.token));
  });
}
