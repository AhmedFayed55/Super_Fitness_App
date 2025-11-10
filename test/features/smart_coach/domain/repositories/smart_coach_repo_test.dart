import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

import 'smart_coach_repo_test.mocks.dart';

// ignore: subtype_of_sealed_class
class FakeDocumentReference implements DocumentReference {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void _registerDummyValues() {
  provideDummy<ApiResult<GetUserDataResponseEntity>>(
    ApiSuccessResult(
      data: const GetUserDataResponseEntity(
        message: 'Success',
        user: UserEntity(
          id: '1',
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
        ),
      ),
    ),
  );

  provideDummy<FirebaseResult<DocumentReference>>(
    FirebaseSuccessResult(data: FakeDocumentReference()),
  );

  provideDummy<FirebaseResult<void>>(FirebaseSuccessResult(data: null));

  provideDummy<FirebaseResult<List<ChatMetadataEntity>>>(
    FirebaseSuccessResult(data: []),
  );

  provideDummy<FirebaseResult<ChatEntity>>(
    FirebaseSuccessResult(
      data: const ChatEntity(id: 'chat1', title: 'Chat', messages: []),
    ),
  );
}

@GenerateMocks([SmartCoachRepository])
void main() {
  late MockSmartCoachRepository mockRepo;

  setUpAll(() {
    _registerDummyValues();
  });

  setUp(() {
    mockRepo = MockSmartCoachRepository();
  });

  group('SmartCoachRepository contract tests', () {
    test('getUserData returns ApiResult<GetUserDataResponseEntity>', () async {
      const response = GetUserDataResponseEntity(
        message: 'Success',
        user: UserEntity(
          id: '1',
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
        ),
      );

      when(
        mockRepo.getUserData(),
      ).thenAnswer((_) async => ApiSuccessResult(data: response));

      final result = await mockRepo.getUserData();

      expect(result, isA<ApiSuccessResult<GetUserDataResponseEntity>>());
      verify(mockRepo.getUserData()).called(1);
    });

    test('createChat returns FirebaseResult<DocumentReference>', () async {
      final docRef = FakeDocumentReference();

      when(
        mockRepo.createChat('1', 'New Chat'),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: docRef));

      final result = await mockRepo.createChat('1', 'New Chat');

      expect(result, isA<FirebaseSuccessResult<DocumentReference>>());
      verify(mockRepo.createChat('1', 'New Chat')).called(1);
    });

    test('saveMessage returns FirebaseResult<void>', () async {
      final message = MessageEntity(
        id: '1',
        text: 'Hi',
        sender: 'user',
        timestamp: DateTime.now(),
      );

      when(
        mockRepo.saveMessage(userId: '1', chatId: 'chat1', message: message),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

      final result = await mockRepo.saveMessage(
        userId: '1',
        chatId: 'chat1',
        message: message,
      );

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(
        mockRepo.saveMessage(userId: '1', chatId: 'chat1', message: message),
      ).called(1);
    });

    test('saveMessagesBatch returns FirebaseResult<void>', () async {
      final messages = [
        MessageEntity(
          id: '1',
          text: 'Hi',
          sender: 'user',
          timestamp: DateTime.now(),
        ),
      ];

      when(
        mockRepo.saveMessagesBatch(
          userId: '1',
          chatId: 'chat1',
          messages: messages,
        ),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

      final result = await mockRepo.saveMessagesBatch(
        userId: '1',
        chatId: 'chat1',
        messages: messages,
      );

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(
        mockRepo.saveMessagesBatch(
          userId: '1',
          chatId: 'chat1',
          messages: messages,
        ),
      ).called(1);
    });

    test(
      'getUserChats returns FirebaseResult<List<ChatMetadataEntity>>',
      () async {
        final chats = [
          ChatMetadataEntity(
            id: 'chat1',
            title: 'Morning Plan',
            createdAt: DateTime.now(),
            lastMessageAt: DateTime.now(),
            messageCount: 5,
          ),
        ];

        when(
          mockRepo.getUserChats('1'),
        ).thenAnswer((_) async => FirebaseSuccessResult(data: chats));

        final result = await mockRepo.getUserChats('1');

        expect(result, isA<FirebaseSuccessResult<List<ChatMetadataEntity>>>());
        verify(mockRepo.getUserChats('1')).called(1);
      },
    );

    test('getChatWithMessages returns FirebaseResult<ChatEntity>', () async {
      const chat = ChatEntity(id: 'chat1', title: 'Chat', messages: []);

      when(
        mockRepo.getChatWithMessages('1', 'chat1'),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: chat));

      final result = await mockRepo.getChatWithMessages('1', 'chat1');

      expect(result, isA<FirebaseSuccessResult<ChatEntity>>());
      verify(mockRepo.getChatWithMessages('1', 'chat1')).called(1);
    });

    test('deleteChat returns FirebaseResult<void>', () async {
      when(
        mockRepo.deleteChat('1', 'chat1'),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

      final result = await mockRepo.deleteChat('1', 'chat1');

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(mockRepo.deleteChat('1', 'chat1')).called(1);
    });

    test('clearChatMessages returns FirebaseResult<void>', () async {
      when(
        mockRepo.clearChatMessages('1', 'chat1'),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

      final result = await mockRepo.clearChatMessages('1', 'chat1');

      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(mockRepo.clearChatMessages('1', 'chat1')).called(1);
    });
  });
}
