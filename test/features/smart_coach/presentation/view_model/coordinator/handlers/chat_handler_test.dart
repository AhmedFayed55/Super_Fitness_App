import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/create_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/delete_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_chat_messages_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_chats_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/handlers/chat_handler.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';

import 'chat_handler_test.mocks.dart';

// ignore: subtype_of_sealed_class
class FakeDocumentReference implements DocumentReference {
  final String _id;

  FakeDocumentReference(this._id);

  @override
  String get id => _id;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

@GenerateMocks([
  CreateChatUseCase,
  GetUserChatsUseCase,
  GetChatWithMessagesUseCase,
  DeleteChatUseCase,
])
void main() {
  late MockCreateChatUseCase mockCreateChatUseCase;
  late MockGetUserChatsUseCase mockGetUserChatsUseCase;
  late MockGetChatWithMessagesUseCase mockGetChatWithMessagesUseCase;
  late MockDeleteChatUseCase mockDeleteChatUseCase;
  late ChatHandler chatHandler;
  late SmartChatState currentState;
  late List<SmartChatState> emittedStates;
  late UserEntity testUser;
  late DocumentReference? currentChatRef;
  late FakeDocumentReference fakeDocRef;

  setUpAll(() {
    provideDummy<FirebaseResult<DocumentReference>>(
      FirebaseSuccessResult(data: FakeDocumentReference('chat_1')),
    );
    provideDummy<FirebaseResult<void>>(FirebaseSuccessResult(data: null));
    provideDummy<FirebaseResult<List<ChatMetadataEntity>>>(
      FirebaseSuccessResult(data: []),
    );
    provideDummy<FirebaseResult<ChatEntity>>(
      FirebaseSuccessResult(
        data: const ChatEntity(id: 'chat_1', title: 'Chat', messages: []),
      ),
    );
  });

  setUp(() {
    mockCreateChatUseCase = MockCreateChatUseCase();
    mockGetUserChatsUseCase = MockGetUserChatsUseCase();
    mockGetChatWithMessagesUseCase = MockGetChatWithMessagesUseCase();
    mockDeleteChatUseCase = MockDeleteChatUseCase();

    fakeDocRef = FakeDocumentReference('chat_1');
    currentChatRef = null;
    emittedStates = [];

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
      userChats: const [],
      chatController: InMemoryChatController(),
    );

    when(
      mockCreateChatUseCase.call(any, any),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: fakeDocRef));
    when(
      mockGetUserChatsUseCase.call(any),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: []));
    when(mockGetChatWithMessagesUseCase.call(any, any)).thenAnswer(
      (_) async => FirebaseSuccessResult(
        data: const ChatEntity(id: 'chat_1', title: 'Chat', messages: []),
      ),
    );
    when(
      mockDeleteChatUseCase.call(any, any),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

    chatHandler = ChatHandler(
      createChatUseCase: mockCreateChatUseCase,
      getUserChatsUseCase: mockGetUserChatsUseCase,
      getChatWithMessagesUseCase: mockGetChatWithMessagesUseCase,
      deleteChatUseCase: mockDeleteChatUseCase,
      emit: (s) {
        emittedStates.add(s);
        currentState = s;
      },
      getState: () => currentState,
      getCurrentChatRef: () => currentChatRef,
      setCurrentChatRef: (ref) => currentChatRef = ref,
    );
  });
  group('ChatHandler.createNewChat', () {
    test('creates new chat successfully', () async {
      when(
        mockCreateChatUseCase.call(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: fakeDocRef));

      await chatHandler.createNewChat();

      verify(mockCreateChatUseCase.call(any, any)).called(1);
      expect(emittedStates.last.currentChatId, equals('chat_1'));
      expect(currentChatRef, equals(fakeDocRef));
    });

    test('handles FirebaseErrorResult', () async {
      when(mockCreateChatUseCase.call(any, any)).thenAnswer(
        (_) async => FirebaseErrorResult(
          failure: Failure(errorMessage: 'create failed'),
        ),
      );

      await chatHandler.createNewChat();

      expect(emittedStates.last.error, equals('create failed'));
    });

    test('handles exception', () async {
      when(
        mockCreateChatUseCase.call(any, any),
      ).thenThrow(Exception('unexpected error'));

      await chatHandler.createNewChat();

      expect(emittedStates.last.error, contains('unexpected error'));
    });
  });

  group('ChatHandler.createOrGetCurrentChat', () {
    test('returns existing chat when currentChatRef is not null', () async {
      currentChatRef = fakeDocRef;

      final result = await chatHandler.createOrGetCurrentChat();

      expect(result, equals(fakeDocRef));
      verifyNever(mockCreateChatUseCase.call(any, any));
    });

    test('creates new chat when currentChatRef is null', () async {
      currentChatRef = null;

      when(
        mockCreateChatUseCase.call(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: fakeDocRef));

      final result = await chatHandler.createOrGetCurrentChat();

      expect(result, equals(fakeDocRef));
      expect(emittedStates.last.currentChatId, equals('chat_1'));
      expect(currentChatRef, equals(fakeDocRef));
      verify(mockCreateChatUseCase.call(any, any)).called(1);
    });

    test('creates new chat with firstMessage as title', () async {
      currentChatRef = null;

      when(
        mockCreateChatUseCase.call(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: fakeDocRef));

      await chatHandler.createOrGetCurrentChat(firstMessage: 'Hello');

      verify(
        mockCreateChatUseCase.call(any, argThat(contains('Hello'))),
      ).called(1);
    });

    test('returns null on FirebaseErrorResult', () async {
      currentChatRef = null;

      when(mockCreateChatUseCase.call(any, any)).thenAnswer(
        (_) async => FirebaseErrorResult(
          failure: Failure(errorMessage: 'create failed'),
        ),
      );

      final result = await chatHandler.createOrGetCurrentChat();

      expect(result, isNull);
      expect(emittedStates.last.error, equals('create failed'));
    });
  });

  group('ChatHandler.loadUserChats', () {
    test('loads user chats successfully', () async {
      final chats = [
        const ChatMetadataEntity(
          id: 'chat_1',
          title: 'Chat 1',
          messageCount: 5,
        ),
        const ChatMetadataEntity(
          id: 'chat_2',
          title: 'Chat 2',
          messageCount: 3,
        ),
      ];

      when(
        mockGetUserChatsUseCase.call(any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: chats));

      await chatHandler.loadUserChats();

      expect(emittedStates.last.userChats.length, equals(2));
      expect(emittedStates.last.userChats.first.id, equals('chat_1'));
      expect(emittedStates.last.isLoadingChats, false);
      expect(emittedStates.last.hasLoadedChats, true);
      expect(emittedStates.last.error, isNull);
      verify(mockGetUserChatsUseCase.call(testUser.id)).called(1);
    });

    test('creates new chat when chats list is empty', () async {
      when(
        mockGetUserChatsUseCase.call(any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: []));

      when(
        mockCreateChatUseCase.call(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: fakeDocRef));

      await chatHandler.loadUserChats();

      expect(emittedStates.last.userChats, isEmpty);
      verify(mockCreateChatUseCase.call(any, any)).called(1);
    });

    test('sets isLoadingChats to true initially', () async {
      when(
        mockGetUserChatsUseCase.call(any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: []));

      when(
        mockCreateChatUseCase.call(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: fakeDocRef));

      await chatHandler.loadUserChats();

      expect(emittedStates.any((s) => s.isLoadingChats == true), true);
    });
  });

  group('ChatHandler.selectChat', () {
    test('calls use case and sets loading state', () async {
      final chatEntity = ChatEntity(
        id: 'chat_1',
        title: 'Test Chat',
        messages: [
          MessageEntity(
            id: 'm1',
            text: 'Hello',
            sender: 'user',
            timestamp: DateTime.now(),
          ),
        ],
      );

      when(
        mockGetChatWithMessagesUseCase.call(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: chatEntity));

      try {
        await chatHandler.selectChat('chat_1');
        // ignore: empty_catches
      } catch (e) {}

      verify(
        mockGetChatWithMessagesUseCase.call(testUser.id, 'chat_1'),
      ).called(1);
      expect(emittedStates.any((s) => s.isLoadingMessages == true), true);
    });

    test('handles FirebaseErrorResult', () async {
      when(mockGetChatWithMessagesUseCase.call(any, any)).thenAnswer(
        (_) async =>
            FirebaseErrorResult(failure: Failure(errorMessage: 'load failed')),
      );

      await chatHandler.selectChat('chat_1');

      expect(emittedStates.last.error, equals('load failed'));
      expect(emittedStates.last.isLoadingMessages, false);
    });
  });

  group('ChatHandler.deleteChat', () {
    test(
      'does not clear current chat when deleted chat is not current',
      () async {
        final chats = [
          const ChatMetadataEntity(
            id: 'chat_1',
            title: 'Chat 1',
            messageCount: 5,
          ),
          const ChatMetadataEntity(
            id: 'chat_2',
            title: 'Chat 2',
            messageCount: 3,
          ),
        ];

        final otherDocRef = FakeDocumentReference('chat_2');
        currentState = currentState.copyWith(userChats: chats);
        currentChatRef = otherDocRef;

        when(
          mockDeleteChatUseCase.call(any, any),
        ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

        await chatHandler.deleteChat('chat_1');

        expect(currentChatRef, equals(otherDocRef));
        expect(emittedStates.last.currentChatId, equals('chat_2'));
      },
    );

    test('handles FirebaseErrorResult', () async {
      final chats = [
        const ChatMetadataEntity(
          id: 'chat_1',
          title: 'Chat 1',
          messageCount: 5,
        ),
      ];

      currentState = currentState.copyWith(userChats: chats);

      when(mockDeleteChatUseCase.call(any, any)).thenAnswer(
        (_) async => FirebaseErrorResult(
          failure: Failure(errorMessage: 'delete failed'),
        ),
      );

      await chatHandler.deleteChat('chat_1');

      expect(emittedStates.last.error, equals('delete failed'));
      expect(emittedStates.last.userChats.length, equals(1));
    });
  });

  group('ChatHandler.toggleDrawer', () {
    test('toggles drawer from false to true', () {
      currentState = currentState.copyWith(showDrawer: false);

      chatHandler.toggleDrawer();

      expect(emittedStates.last.showDrawer, true);
    });

    test('toggles drawer from true to false', () {
      currentState = currentState.copyWith(showDrawer: true);

      chatHandler.toggleDrawer();

      expect(emittedStates.last.showDrawer, false);
    });

    test('loads user chats when drawer opens and chats are empty', () async {
      currentState = currentState.copyWith(showDrawer: false, userChats: []);

      when(
        mockGetUserChatsUseCase.call(any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: []));

      when(
        mockCreateChatUseCase.call(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: fakeDocRef));

      chatHandler.toggleDrawer();

      await Future.delayed(const Duration(milliseconds: 100));

      verify(mockGetUserChatsUseCase.call(testUser.id)).called(1);
    });
  });
}
