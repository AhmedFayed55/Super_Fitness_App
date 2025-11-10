import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_metadata_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_firebase_ds.dart';

import 'smart_coach_firebase_ds_test.mocks.dart';

@GenerateMocks([SmartCoachFirebaseDs, DocumentReference])
void main() {
  late MockSmartCoachFirebaseDs mockFirebaseDs;
  late MockDocumentReference mockDocumentRef;

  setUp(() {
    mockFirebaseDs = MockSmartCoachFirebaseDs();
    mockDocumentRef = MockDocumentReference();
  });

  group('SmartCoachFirebaseDs', () {
    test('createChat returns DocumentReference', () async {
      when(
        mockFirebaseDs.createChat(userId: '1', title: 'New Chat'),
      ).thenAnswer((_) async => mockDocumentRef);

      final result = await mockFirebaseDs.createChat(
        userId: '1',
        title: 'New Chat',
      );

      expect(result, isA<DocumentReference>());
      verify(
        mockFirebaseDs.createChat(userId: '1', title: 'New Chat'),
      ).called(1);
    });

    test('saveMessage completes successfully', () async {
      final message = MessageDto(
        id: '1',
        text: 'Hi',
        sender: 'user',
        timestamp: 12345,
      );

      when(
        mockFirebaseDs.saveMessage(
          userId: '1',
          chatId: 'chat1',
          message: message,
        ),
      ).thenAnswer((_) async {});

      await mockFirebaseDs.saveMessage(
        userId: '1',
        chatId: 'chat1',
        message: message,
      );

      verify(
        mockFirebaseDs.saveMessage(
          userId: '1',
          chatId: 'chat1',
          message: message,
        ),
      ).called(1);
    });

    test('saveMessagesBatch completes successfully', () async {
      final messages = [
        MessageDto(id: '1', text: 'Hi', sender: 'user', timestamp: 12345),
        MessageDto(id: '2', text: 'Hello', sender: 'coach', timestamp: 12346),
      ];

      when(
        mockFirebaseDs.saveMessagesBatch(
          userId: '1',
          chatId: 'chat1',
          messages: messages,
        ),
      ).thenAnswer((_) async {});

      await mockFirebaseDs.saveMessagesBatch(
        userId: '1',
        chatId: 'chat1',
        messages: messages,
      );

      verify(
        mockFirebaseDs.saveMessagesBatch(
          userId: '1',
          chatId: 'chat1',
          messages: messages,
        ),
      ).called(1);
    });

    test('getUserChats returns List<ChatMetadataDto>', () async {
      final chats = [
        ChatMetadataDto(
          id: 'chat1',
          title: 'Morning Plan',
          createdAt: Timestamp.fromDate(DateTime(2025, 11, 1)),
          lastMessageAt: Timestamp.fromDate(DateTime(2025, 11, 9)),
          messageCount: 10,
        ),
      ];

      when(mockFirebaseDs.getUserChats('1')).thenAnswer((_) async => chats);

      final result = await mockFirebaseDs.getUserChats('1');

      expect(result, isA<List<ChatMetadataDto>>());
      expect(result.first.id, 'chat1');
      verify(mockFirebaseDs.getUserChats('1')).called(1);
    });

    test('getChatWithMessages returns ChatDto', () async {
      final chat = ChatDto(
        id: 'chat1',
        title: 'Session',
        messages: [
          MessageDto(id: '1', text: 'Hi', sender: 'user', timestamp: 12345),
        ],
      );

      when(
        mockFirebaseDs.getChatWithMessages(userId: '1', chatId: 'chat1'),
      ).thenAnswer((_) async => chat);

      final result = await mockFirebaseDs.getChatWithMessages(
        userId: '1',
        chatId: 'chat1',
      );

      expect(result, isA<ChatDto>());
      expect(result.id, 'chat1');
      verify(
        mockFirebaseDs.getChatWithMessages(userId: '1', chatId: 'chat1'),
      ).called(1);
    });

    test('deleteChat completes successfully', () async {
      when(
        mockFirebaseDs.deleteChat(userId: '1', chatId: 'chat1'),
      ).thenAnswer((_) async {});

      await mockFirebaseDs.deleteChat(userId: '1', chatId: 'chat1');

      verify(mockFirebaseDs.deleteChat(userId: '1', chatId: 'chat1')).called(1);
    });

    test('clearChatMessages completes successfully', () async {
      when(
        mockFirebaseDs.clearChatMessages(userId: '1', chatId: 'chat1'),
      ).thenAnswer((_) async {});

      await mockFirebaseDs.clearChatMessages(userId: '1', chatId: 'chat1');

      verify(
        mockFirebaseDs.clearChatMessages(userId: '1', chatId: 'chat1'),
      ).called(1);
    });
  });
}
