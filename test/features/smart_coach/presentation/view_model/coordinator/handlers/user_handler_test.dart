import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_data_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/coordinator/handlers/user_handler.dart';

import 'user_handler_test.mocks.dart';

@GenerateMocks([GetUserDataUseCase])
void main() {
  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late UserHandler userHandler;
  late SmartChatState currentState;
  late List<SmartChatState> emittedStates;
  late bool loadUserChatsCalled;

  setUpAll(() {
    provideDummy<ApiResult<GetUserDataResponseEntity>>(
      ApiSuccessResult(
        data: const GetUserDataResponseEntity(
          message: '',
          user: UserEntity(
            id: '',
            firstName: '',
            lastName: '',
            email: '',
            gender: '',
            age: 0,
            weight: 0,
            height: 0,
            activityLevel: '',
            goal: '',
            photo: '',
            createdAt: '',
          ),
        ),
      ),
    );
  });

  setUp(() {
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    emittedStates = [];
    loadUserChatsCalled = false;
    currentState = SmartChatState(
      user: null,
      isLoadingUser: false,
      error: null,
      chatController: InMemoryChatController(),
    );

    userHandler = UserHandler(
      getUserDataUseCase: mockGetUserDataUseCase,
      emit: (s) {
        emittedStates.add(s);
        currentState = s;
      },
      getState: () => currentState,
      loadUserChats: () async {
        loadUserChatsCalled = true;
      },
    );
  });
  group('UserHandler.loadUserData', () {
    test('emits correct states and calls loadUserChats on success', () async {
      const user = UserEntity(
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

      when(mockGetUserDataUseCase.call()).thenAnswer(
        (_) async => ApiSuccessResult(
          data: const GetUserDataResponseEntity(message: 'ok', user: user),
        ),
      );

      await userHandler.loadUserData();

      expect(emittedStates.length, greaterThanOrEqualTo(2));
      expect(emittedStates.first.isLoadingUser, true);
      expect(emittedStates.last.isLoadingUser, false);
      expect(emittedStates.last.user, equals(user));
      expect(emittedStates.last.error, isNull);
      expect(loadUserChatsCalled, true);
    });

    test('emits correct states and sets error on failure', () async {
      when(mockGetUserDataUseCase.call()).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: 'Network error')),
      );

      await userHandler.loadUserData();

      expect(emittedStates.length, greaterThanOrEqualTo(2));
      expect(emittedStates.first.isLoadingUser, true);
      expect(emittedStates.last.isLoadingUser, false);
      expect(emittedStates.last.error, equals('Network error'));
      expect(loadUserChatsCalled, false);
    });
  });
}
