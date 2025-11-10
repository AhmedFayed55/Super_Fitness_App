import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_metadata_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/response/get_user_data_response_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/user_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/repositories/smart_coach_repo_impl.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_firebase_ds.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_remote_ds.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';

import 'smart_coach_repo_impl_test.mocks.dart';

@GenerateMocks([SmartCoachRemoteDs, SmartCoachFirebaseDs, DocumentReference])
void main() {
  late MockSmartCoachRemoteDs mockRemoteDs;
  late MockSmartCoachFirebaseDs mockFirebaseDs;
  late MockDocumentReference mockDocumentRef;
  late SmartCoachRepositoryImpl repo;

  setUp(() {
    mockRemoteDs = MockSmartCoachRemoteDs();
    mockFirebaseDs = MockSmartCoachFirebaseDs();
    mockDocumentRef = MockDocumentReference();
    repo = SmartCoachRepositoryImpl(mockRemoteDs, mockFirebaseDs);
  });

  group('getUserData', () {
    test('returns success when remote call succeeds', () async {
      final responseDto = GetUserDataResponseDto(
        message: 'Success',
        user: UserDto(
          id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          gender: 'male',
          age: 30,
          weight: 75,
          height: 180,
          activityLevel: 'level1',
          goal: 'Maintain weight',
        ),
      );

      when(mockRemoteDs.getUserData()).thenAnswer((_) async => responseDto);

      final result = await repo.getUserData();

      expect(result, isA<ApiSuccessResult<dynamic>>());
      verify(mockRemoteDs.getUserData()).called(1);
    });

    test('returns error when remote throws', () async {
      when(mockRemoteDs.getUserData()).thenThrow(Exception('server error'));

      final result = await repo.getUserData();

      expect(result, isA<ApiErrorResult<dynamic>>());
    });
  });

  group('createChat', () {
    test('returns success when firebase call succeeds', () async {
      const userId = '1';
      const title = 'New Chat';

      when(
        mockFirebaseDs.createChat(userId: userId, title: title),
      ).thenAnswer((_) async => mockDocumentRef);

      final result = await repo.createChat(userId, title);

      expect(result, isA<FirebaseSuccessResult<DocumentReference>>());
      verify(mockFirebaseDs.createChat(userId: userId, title: title)).called(1);
    });

    test('returns error when firebase throws', () async {
      const userId = '1';
      const title = 'New Chat';

      when(
        mockFirebaseDs.createChat(userId: userId, title: title),
      ).thenThrow(Exception('firebase error'));

      final result = await repo.createChat(userId, title);

      expect(result, isA<FirebaseErrorResult<DocumentReference>>());
    });
  });

  group('saveMessage', () {
    test('returns success when firebase call succeeds', () async {
      const userId = '1';
      const chatId = 'chat1';
      final messageEntity = MessageEntity(
        id: 'msg1',
        text: 'Hello',
        sender: 'user',
        timestamp: DateTime.now(),
      );

      when(
        mockFirebaseDs.saveMessage(
          userId: userId,
          chatId: chatId,
          message: anyNamed('message'),
        ),
      ).thenAnswer((_) async => Future.value());

      final result = await repo.saveMessage(
        userId: userId,
        chatId: chatId,
        message: messageEntity,
      );

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(
        mockFirebaseDs.saveMessage(
          userId: userId,
          chatId: chatId,
          message: anyNamed('message'),
        ),
      ).called(1);
    });

    test('returns error when firebase throws', () async {
      const userId = '1';
      const chatId = 'chat1';
      final messageEntity = MessageEntity(
        id: 'msg1',
        text: 'Hello',
        sender: 'user',
        timestamp: DateTime.now(),
      );

      when(
        mockFirebaseDs.saveMessage(
          userId: userId,
          chatId: chatId,
          message: anyNamed('message'),
        ),
      ).thenThrow(Exception('firebase error'));

      final result = await repo.saveMessage(
        userId: userId,
        chatId: chatId,
        message: messageEntity,
      );

      expect(result, isA<FirebaseErrorResult<void>>());
    });
  });

  group('saveMessagesBatch', () {
    test('returns success when firebase call succeeds', () async {
      const userId = '1';
      const chatId = 'chat1';
      final messages = [
        MessageEntity(
          id: 'msg1',
          text: 'Hi',
          sender: 'user',
          timestamp: DateTime.now(),
        ),
        MessageEntity(
          id: 'msg2',
          text: 'Hello',
          sender: 'coach',
          timestamp: DateTime.now(),
        ),
      ];

      when(
        mockFirebaseDs.saveMessagesBatch(
          userId: userId,
          chatId: chatId,
          messages: anyNamed('messages'),
        ),
      ).thenAnswer((_) async => Future.value());

      final result = await repo.saveMessagesBatch(
        userId: userId,
        chatId: chatId,
        messages: messages,
      );

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(
        mockFirebaseDs.saveMessagesBatch(
          userId: userId,
          chatId: chatId,
          messages: anyNamed('messages'),
        ),
      ).called(1);
    });

    test('returns error when firebase throws', () async {
      const userId = '1';
      const chatId = 'chat1';
      final messages = [
        MessageEntity(
          id: 'msg1',
          text: 'Hi',
          sender: 'user',
          timestamp: DateTime.now(),
        ),
      ];

      when(
        mockFirebaseDs.saveMessagesBatch(
          userId: userId,
          chatId: chatId,
          messages: anyNamed('messages'),
        ),
      ).thenThrow(Exception('firebase error'));

      final result = await repo.saveMessagesBatch(
        userId: userId,
        chatId: chatId,
        messages: messages,
      );

      expect(result, isA<FirebaseErrorResult<void>>());
    });
  });

  group('getUserChats', () {
    test('returns success when firebase call succeeds', () async {
      const userId = '1';
      final chats = [
        ChatMetadataDto(
          id: 'chat1',
          title: 'Morning Plan',
          createdAt: Timestamp.fromDate(DateTime(2025, 11, 1)),
          lastMessageAt: Timestamp.fromDate(DateTime(2025, 11, 9)),
          messageCount: 10,
        ),
      ];

      when(mockFirebaseDs.getUserChats(userId)).thenAnswer((_) async => chats);

      final result = await repo.getUserChats(userId);

      expect(result, isA<FirebaseSuccessResult<List<ChatMetadataEntity>>>());
      final successResult =
          result as FirebaseSuccessResult<List<ChatMetadataEntity>>;
      expect(successResult.data, isA<List<ChatMetadataEntity>>());
      expect(successResult.data.first.id, 'chat1');
      verify(mockFirebaseDs.getUserChats(userId)).called(1);
    });

    test('returns error when firebase throws', () async {
      const userId = '1';

      when(
        mockFirebaseDs.getUserChats(userId),
      ).thenThrow(Exception('firebase error'));

      final result = await repo.getUserChats(userId);

      expect(result, isA<FirebaseErrorResult<List<ChatMetadataEntity>>>());
    });
  });

  group('getChatWithMessages', () {
    test('returns success when firebase call succeeds', () async {
      const userId = '1';
      const chatId = 'chat1';
      final chatDto = ChatDto(
        id: chatId,
        title: 'Session',
        messages: [
          MessageDto(id: 'msg1', text: 'Hi', sender: 'user', timestamp: 12345),
        ],
      );

      when(
        mockFirebaseDs.getChatWithMessages(userId: userId, chatId: chatId),
      ).thenAnswer((_) async => chatDto);

      final result = await repo.getChatWithMessages(userId, chatId);

      expect(result, isA<FirebaseSuccessResult<ChatEntity>>());
      expect((result as FirebaseSuccessResult<ChatEntity>).data.id, chatId);
      verify(
        mockFirebaseDs.getChatWithMessages(userId: userId, chatId: chatId),
      ).called(1);
    });

    test('returns error when firebase throws', () async {
      const userId = '1';
      const chatId = 'chat1';

      when(
        mockFirebaseDs.getChatWithMessages(userId: userId, chatId: chatId),
      ).thenThrow(Exception('firebase error'));

      final result = await repo.getChatWithMessages(userId, chatId);

      expect(result, isA<FirebaseErrorResult<ChatEntity>>());
    });
  });

  group('deleteChat', () {
    test('returns success when firebase call succeeds', () async {
      const userId = '1';
      const chatId = 'chat1';

      when(
        mockFirebaseDs.deleteChat(userId: userId, chatId: chatId),
      ).thenAnswer((_) async => Future.value());

      final result = await repo.deleteChat(userId, chatId);

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(
        mockFirebaseDs.deleteChat(userId: userId, chatId: chatId),
      ).called(1);
    });

    test('returns error when firebase throws', () async {
      const userId = '1';
      const chatId = 'chat1';

      when(
        mockFirebaseDs.deleteChat(userId: userId, chatId: chatId),
      ).thenThrow(Exception('firebase error'));

      final result = await repo.deleteChat(userId, chatId);

      expect(result, isA<FirebaseErrorResult<void>>());
    });
  });

  group('clearChatMessages', () {
    test('returns success when firebase call succeeds', () async {
      const userId = '1';
      const chatId = 'chat1';

      when(
        mockFirebaseDs.clearChatMessages(userId: userId, chatId: chatId),
      ).thenAnswer((_) async => Future.value());

      final result = await repo.clearChatMessages(userId, chatId);

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(
        mockFirebaseDs.clearChatMessages(userId: userId, chatId: chatId),
      ).called(1);
    });

    test('returns error when firebase throws', () async {
      const userId = '1';
      const chatId = 'chat1';

      when(
        mockFirebaseDs.clearChatMessages(userId: userId, chatId: chatId),
      ).thenThrow(Exception('firebase error'));

      final result = await repo.clearChatMessages(userId, chatId);

      expect(result, isA<FirebaseErrorResult<void>>());
    });
  });
}
