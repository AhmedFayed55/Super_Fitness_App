import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/logout/data/mapper/to_logout_entity.dart';
import 'package:super_fitness_app/features/auth/logout/data/model/logout_response_dto.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';

void main() {
  group('LogoutMapper', () {
    test('should map LogoutResponseDto to LogoutEntity correctly', () {
      final dto = LogoutResponseDto(message: "Logout success");

      final entity = dto.toEntity();

      expect(entity, isA<LogoutEntity>());
      expect(entity.message, "Logout success");
    });

    test('should handle null message by returning empty string', () {
      final dto = LogoutResponseDto(message: null);

      final entity = dto.toEntity();

      expect(entity.message, '');
    });
  });
}
