import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';

void main() {
  group('MessageEntityMapper Tests', () {
    test('MessageEntity → MessageDto mapping should be correct', () {
      final mockEntity = MessageEntity(
        id: 'msg_001',
        text: 'Hello Coach!',
        sender: 'user',
        timestamp: DateTime(2025, 11, 9, 22, 30, 0),
      );

      final result = mockEntity.toDto();

      expect(result, isA<MessageDto>());
      expect(result.id, mockEntity.id);
      expect(result.text, mockEntity.text);
      expect(result.sender, mockEntity.sender);
      expect(result.timestamp, mockEntity.timestamp.millisecondsSinceEpoch);
    });
  });
}
