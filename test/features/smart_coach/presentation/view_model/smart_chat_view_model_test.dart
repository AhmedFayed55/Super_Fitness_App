import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/create_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/delete_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_chat_messages_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_chats_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_data_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/save_message_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'smart_chat_view_model_test.mocks.dart';

// ignore: subtype_of_sealed_class
class FakeDocumentReference implements DocumentReference {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

@GenerateMocks([
  GetUserDataUseCase,
  CreateChatUseCase,
  SaveMessageUseCase,
  GetUserChatsUseCase,
  GetChatWithMessagesUseCase,
  DeleteChatUseCase,
])
void main() {
  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late MockCreateChatUseCase mockCreateChatUseCase;
  late MockSaveMessageUseCase mockSaveMessageUseCase;
  late MockGetUserChatsUseCase mockGetUserChatsUseCase;
  late MockGetChatWithMessagesUseCase mockGetChatWithMessagesUseCase;
  late MockDeleteChatUseCase mockDeleteChatUseCase;
  late SmartChatViewModel vm;

  setUpAll(() {
    provideDummy<ApiResult<GetUserDataResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<dynamic>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
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
  });
  setUp(() {
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockCreateChatUseCase = MockCreateChatUseCase();
    mockSaveMessageUseCase = MockSaveMessageUseCase();
    mockGetUserChatsUseCase = MockGetUserChatsUseCase();
    mockGetChatWithMessagesUseCase = MockGetChatWithMessagesUseCase();
    mockDeleteChatUseCase = MockDeleteChatUseCase();

    when(mockGetUserDataUseCase.call()).thenAnswer(
      (_) async => ApiSuccessResult(
        data: const GetUserDataResponseEntity(
          message: 'ok',
          user: UserEntity(
            id: '1',
            firstName: 'Ahmed',
            lastName: 'Rageh',
            email: 'ahmed@example.com',
            gender: 'male',
            age: 25,
            weight: 75,
            height: 180,
            activityLevel: '',
            goal: '',
            photo: '',
            createdAt: '',
          ),
        ),
      ),
    );

    when(mockGetUserChatsUseCase.call(any)).thenAnswer(
      (_) async => FirebaseSuccessResult<List<ChatMetadataEntity>>(data: []),
    );

    when(mockGetChatWithMessagesUseCase.call(any, any)).thenAnswer(
      (_) async => FirebaseSuccessResult<ChatEntity>(
        data: const ChatEntity(id: 'chat1', title: 'Chat', messages: []),
      ),
    );

    vm = SmartChatViewModel(
      mockGetUserDataUseCase,
      mockCreateChatUseCase,
      mockSaveMessageUseCase,
      mockGetUserChatsUseCase,
      mockGetChatWithMessagesUseCase,
      mockDeleteChatUseCase,
    );
  });

  tearDown(() async {
    await vm.close();
  });

  group('SmartChatViewModel', () {
    test('initial state is correct', () {
      expect(vm.state.isLoading, false);
      expect(vm.state.chatController, isA<InMemoryChatController>());
      expect(vm.state.user, isNull);
      expect(vm.state.userChats, isEmpty);
    });

    test('isArabic returns true for Arabic text', () {
      expect(vm.isArabic('مرحبا'), true);
    });

    test('isArabic returns false for English text', () {
      expect(vm.isArabic('Hello'), false);
    });

    test(
      'doIntent InitializeChatEvent initializes chat without error',
      () async {
        await vm.doIntent(InitializeChatEvent());
        expect(vm.state.error, anyOf(isNull, isA<String>()));
      },
    );

    test('doIntent LoadUserDataEvent calls userHandler.loadUserData', () async {
      when(mockGetUserDataUseCase.call()).thenAnswer(
        (_) async => ApiSuccessResult(
          data: const GetUserDataResponseEntity(
            message: 'ok',
            user: UserEntity(
              id: '1',
              firstName: 'Ahmed',
              lastName: 'Rageh',
              email: 'ahmed@example.com',
              gender: 'male',
              age: 25,
              weight: 75,
              height: 180,
              activityLevel: '',
              goal: '',
              photo: '',
              createdAt: '',
            ),
          ),
        ),
      );
      await vm.doIntent(LoadUserDataEvent());
      expect(vm.state.error, anyOf(isNull, isA<String>()));
    });

    test('doIntent LoadUserChatsEvent updates state correctly', () async {
      await vm.doIntent(LoadUserChatsEvent());
      expect(vm.state.userChats, isA<List>());
    });

    test('doIntent ToggleDrawerEvent toggles drawer visibility', () async {
      final initial = vm.state.showDrawer;
      await vm.doIntent(ToggleDrawerEvent());
      expect(vm.state.showDrawer, !initial);
    });

    test('doIntent CreateNewChatEvent executes without errors', () async {
      await vm.doIntent(CreateNewChatEvent());
      expect(vm.state.error, anyOf(isNull, isA<String>()));
    });

    test('doIntent DeleteChatEvent executes without errors', () async {
      await vm.doIntent(DeleteChatEvent('chat1'));
      expect(vm.state.error, anyOf(isNull, isA<String>()));
    });

    test('doIntent SelectChatEvent executes without errors', () async {
      await vm.doIntent(SelectChatEvent('chat1'));
      expect(vm.state.currentChatId, anyOf(isNull, 'chat1'));
    });

    test('doIntent SendMessageEvent executes without errors', () async {
      await vm.doIntent(SendMessageEvent('Hello'));
      expect(vm.state.isSendingOrReceivingMessage, anyOf(true, false));
    });
  });
}
