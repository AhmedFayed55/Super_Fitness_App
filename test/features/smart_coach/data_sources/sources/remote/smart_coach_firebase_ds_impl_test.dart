import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/core/services/firebase_services.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_firebase_ds_impl.dart';

import 'smart_coach_firebase_ds_impl_test.mocks.dart';

@GenerateMocks([FirebaseService])
void main() {
  late SmartCoachFirebaseDsImpl dataSource;
  late MockFirebaseService mockFirebaseService;

  setUp(() {
    mockFirebaseService = MockFirebaseService();
    dataSource = SmartCoachFirebaseDsImpl(mockFirebaseService);
  });

  group('SmartCoachFirebaseDsImpl', () {
    test('createChat requires Firebase initialization', () async {
      const userId = '1';
      const title = 'New Chat';

      expect(
        () async => await dataSource.createChat(userId: userId, title: title),
        throwsA(anything),
      );
    });

    test('saveMessage requires Firebase initialization', () async {
      const userId = '1';
      const chatId = 'chat1';
      final message = MessageDto(
        id: '1',
        text: 'Hi',
        sender: 'user',
        timestamp: 12345,
      );

      expect(
        () async => await dataSource.saveMessage(
          userId: userId,
          chatId: chatId,
          message: message,
        ),
        throwsA(anything),
      );
    });

    test('saveMessagesBatch requires Firebase initialization', () async {
      const userId = '1';
      const chatId = 'chat1';
      final messages = [
        MessageDto(id: '1', text: 'Hi', sender: 'user', timestamp: 12345),
        MessageDto(id: '2', text: 'Hello', sender: 'coach', timestamp: 12346),
      ];

      expect(
        () async => await dataSource.saveMessagesBatch(
          userId: userId,
          chatId: chatId,
          messages: messages,
        ),
        throwsA(anything),
      );
    });

    test('getUserChats requires Firebase initialization', () async {
      const userId = '1';

      expect(
        () async => await dataSource.getUserChats(userId),
        throwsA(anything),
      );
    });

    test('getChatWithMessages requires Firebase initialization', () async {
      const userId = '1';
      const chatId = 'chat1';

      expect(
        () async => await dataSource.getChatWithMessages(
          userId: userId,
          chatId: chatId,
        ),
        throwsA(anything),
      );
    });

    test('deleteChat requires Firebase initialization', () async {
      const userId = '1';
      const chatId = 'chat1';

      expect(
        () async => await dataSource.deleteChat(userId: userId, chatId: chatId),
        throwsA(anything),
      );
    });

    test('clearChatMessages requires Firebase initialization', () async {
      const userId = '1';
      const chatId = 'chat1';

      expect(
        () async =>
            await dataSource.clearChatMessages(userId: userId, chatId: chatId),
        throwsA(anything),
      );
    });
  });
}
