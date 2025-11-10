import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/save_message_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/handlers/message_handler.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';

import 'message_handler_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SaveMessageUseCase>(),
  MockSpec<DocumentReference>(),
])
void main() {
  late MockSaveMessageUseCase mockSaveMessageUseCase;
  late MockDocumentReference mockDocumentRef;
  late MessageHandler messageHandler;
  late SmartChatState currentState;
  late List<SmartChatState> emittedStates;
  late bool loadUserChatsCalled;
  late InMemoryChatController chatController;
  late UserEntity testUser;
  late ChatSession realChatSession;

  setUpAll(() {
    provideDummy<FirebaseResult<void>>(FirebaseSuccessResult(data: null));
    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: 'test-key',
    );
    realChatSession = model.startChat();
  });

  setUp(() {
    mockSaveMessageUseCase = MockSaveMessageUseCase();
    mockDocumentRef = MockDocumentReference();

    chatController = InMemoryChatController();
    emittedStates = [];
    loadUserChatsCalled = false;

    testUser = const UserEntity(
      id: '1',
      firstName: 'Ahmed',
      lastName: 'Rageh',
      email: 'ahmed@example.com',
      gender: 'male',
      age: 25,
      weight: 75,
      height: 180,
      activityLevel: 'Active',
      goal: 'Muscle Gain',
      photo: '',
      createdAt: '',
    );

    currentState = SmartChatState(
      user: testUser,
      chatController: chatController,
      isSendingOrReceivingMessage: false,
      error: null,
    );

    messageHandler = MessageHandler(
      saveMessageUseCase: mockSaveMessageUseCase,
      emit: (s) {
        emittedStates.add(s);
        currentState = s;
      },
      getState: () => currentState,
      getChatSession: () => realChatSession,
      getCurrentChatRef: () => mockDocumentRef,
      setCurrentChatRef: (_) {},
      createOrGetCurrentChat: ({String? firstMessage}) async => mockDocumentRef,
      loadUserChatsOnce: () async {
        loadUserChatsCalled = true;
      },
    );
  });

  group('MessageHandler.handleSendMessage', () {
    test('handles empty text (no message sent)', () async {
      await messageHandler.handleSendMessage('');
      expect(chatController.messages, isEmpty);
      verifyNever(
        mockSaveMessageUseCase.call(
          userId: anyNamed('userId'),
          chatId: anyNamed('chatId'),
          text: anyNamed('text'),
          sender: anyNamed('sender'),
        ),
      );
    });

    test('handles whitespace-only text (no message sent)', () async {
      await messageHandler.handleSendMessage('   ');
      expect(chatController.messages, isEmpty);
      verifyNever(
        mockSaveMessageUseCase.call(
          userId: anyNamed('userId'),
          chatId: anyNamed('chatId'),
          text: anyNamed('text'),
          sender: anyNamed('sender'),
        ),
      );
    });

    test('returns early when isSendingOrReceivingMessage is true', () async {
      currentState = currentState.copyWith(isSendingOrReceivingMessage: true);

      await messageHandler.handleSendMessage('Test message');

      expect(chatController.messages, isEmpty);
      verifyNever(
        mockSaveMessageUseCase.call(
          userId: anyNamed('userId'),
          chatId: anyNamed('chatId'),
          text: anyNamed('text'),
          sender: anyNamed('sender'),
        ),
      );
    });

    test('returns early when createOrGetCurrentChat returns null', () async {
      messageHandler = MessageHandler(
        saveMessageUseCase: mockSaveMessageUseCase,
        emit: (s) {
          emittedStates.add(s);
          currentState = s;
        },
        getState: () => currentState,
        getChatSession: () => realChatSession,
        getCurrentChatRef: () => mockDocumentRef,
        setCurrentChatRef: (_) {},
        createOrGetCurrentChat: ({String? firstMessage}) async => null,
        loadUserChatsOnce: () async {
          loadUserChatsCalled = true;
        },
      );

      await messageHandler.handleSendMessage('Test message');

      expect(chatController.messages, isEmpty);
      verifyNever(
        mockSaveMessageUseCase.call(
          userId: anyNamed('userId'),
          chatId: anyNamed('chatId'),
          text: anyNamed('text'),
          sender: anyNamed('sender'),
        ),
      );
    });

    test('saves user message and updates state correctly', () async {
      when(
        mockSaveMessageUseCase.call(
          userId: anyNamed('userId'),
          chatId: anyNamed('chatId'),
          text: anyNamed('text'),
          sender: anyNamed('sender'),
        ),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

      when(mockDocumentRef.id).thenReturn('chat_123');

      try {
        await messageHandler.handleSendMessage('Hi there');
        // ignore: empty_catches
      } catch (e) {}

      expect(chatController.messages.length, greaterThanOrEqualTo(1));
      final firstMessage = chatController.messages.first as TextMessage;
      expect(firstMessage.text, equals('Hi there'));

      expect(emittedStates.any((s) => s.isSendingOrReceivingMessage), true);

      verify(
        mockSaveMessageUseCase.call(
          userId: testUser.id,
          chatId: 'chat_123',
          text: 'Hi there',
          sender: AppConstants.userSender,
        ),
      ).called(1);
    });

    test('loads user chats only once after first message', () async {
      when(
        mockSaveMessageUseCase.call(
          userId: anyNamed('userId'),
          chatId: anyNamed('chatId'),
          text: anyNamed('text'),
          sender: anyNamed('sender'),
        ),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

      when(mockDocumentRef.id).thenReturn('chat_123');

      loadUserChatsCalled = false;
      try {
        await messageHandler.handleSendMessage('First message');
        // ignore: empty_catches
      } catch (e) {}
      expect(loadUserChatsCalled, true);

      loadUserChatsCalled = false;
      try {
        await messageHandler.handleSendMessage('Second message');
        // ignore: empty_catches
      } catch (e) {}
      expect(loadUserChatsCalled, false);
    });
  });
}
