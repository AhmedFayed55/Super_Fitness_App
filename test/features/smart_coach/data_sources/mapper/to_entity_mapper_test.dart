import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/response/get_user_data_response_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/user_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_metadata_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';

void main() {
  group('Smart Coach Mapper (toEntity) Tests', () {
    test('MessageDto → MessageEntity mapping should be correct', () {
      final dto = MessageDto(
        id: 'msg1',
        text: 'Hi there!',
        sender: 'coach',
        timestamp: 1731180000000,
      );

      final result = dto.toEntity();

      expect(result, isA<MessageEntity>());
      expect(result.id, dto.id);
      expect(result.text, dto.text);
      expect(result.sender, dto.sender);
      expect(result.timestamp.millisecondsSinceEpoch, dto.timestamp);
    });

    test('ChatMetadataDto → ChatMetadataEntity mapping should be correct', () {
      final dto = ChatMetadataDto(
        id: 'chat1',
        title: 'My Chat',
        createdAt: Timestamp.fromDate(DateTime(2025, 11, 1)),
        lastMessageAt: Timestamp.fromDate(DateTime(2025, 11, 9)),
        messageCount: 42,
      );

      final result = dto.toEntity();

      expect(result, isA<ChatMetadataEntity>());
      expect(result.id, dto.id);
      expect(result.title, dto.title);
      expect(result.messageCount, dto.messageCount);
    });

    test('ChatDto → ChatEntity mapping should be correct', () {
      final messageDto = MessageDto(
        id: 'm1',
        text: 'Hello!',
        sender: 'user',
        timestamp: 1731180000000,
      );

      final dto = ChatDto(
        id: 'chat1',
        title: 'Test Chat',
        createdAt: Timestamp.fromDate(DateTime(2025, 11, 1)),
        lastMessageAt: Timestamp.fromDate(DateTime(2025, 11, 9)),
        messages: [messageDto],
      );

      final result = dto.toEntity();

      expect(result, isA<ChatEntity>());
      expect(result.id, dto.id);
      expect(result.title, dto.title);
      expect(result.messages.first.text, 'Hello!');
    });

    test('UserDto → UserEntity mapping should be correct', () {
      final dto = UserDto(
        id: 'u1',
        firstName: 'Ahmed',
        lastName: 'Rageh',
        email: 'ahmed@example.com',
        gender: 'male',
        age: 25,
        weight: 75,
        height: 180,
        activityLevel: 'level2',
        goal: 'Build muscle',
        photo: 'profile.png',
        createdAt: '2025-11-09',
      );

      final result = dto.toEntity();

      expect(result, isA<UserEntity>());
      expect(result.id, dto.id);
      expect(result.firstName, dto.firstName);
      expect(result.goal, dto.goal);
    });

    test(
      'GetUserDataResponseDto → GetUserDataResponseEntity mapping should be correct',
      () {
        final userDto = UserDto(
          id: 'u1',
          firstName: 'Ahmed',
          lastName: 'Rageh',
          email: 'ahmed@example.com',
        );

        final dto = GetUserDataResponseDto(
          message: 'User fetched successfully',
          user: userDto,
        );

        final result = dto.toEntity();

        expect(result, isA<GetUserDataResponseEntity>());
        expect(result.message, dto.message);
        expect(result.user.firstName, userDto.firstName);
      },
    );

    test('Null user should map to default user values', () {
      final dto = GetUserDataResponseDto(message: null, user: null);

      final result = dto.toEntity();

      expect(result.message, 'success');
      expect(result.user.firstName, 'Unknown');
      expect(result.user.goal, 'Maintain weight');
    });
  });
}
