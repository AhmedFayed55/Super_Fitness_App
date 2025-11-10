import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_chat_messages_use_case.dart';
import 'get_chat_with_messages_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachRepository])
void main() {
  late MockSmartCoachRepository mockRepo;
  late GetChatWithMessagesUseCase useCase;

  setUp(() {
    mockRepo = MockSmartCoachRepository();
    useCase = GetChatWithMessagesUseCase(mockRepo);
  });

  test('should call repo.getChatWithMessages and return success', () async {
    const userId = 'u1';
    const chatId = 'c1';
    const chat = ChatEntity(id: 'c1', title: 'Chat', messages: []);
    provideDummy<FirebaseResult<ChatEntity>>(FirebaseSuccessResult(data: chat));
    when(
      mockRepo.getChatWithMessages(userId, chatId),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: chat));

    final result = await useCase.call(userId, chatId);

    verify(mockRepo.getChatWithMessages(userId, chatId)).called(1);
    expect(result, isA<FirebaseSuccessResult<ChatEntity>>());
  });

  test('should return error when repo fails', () async {
    const userId = 'u1';
    const chatId = 'c1';
    provideDummy<FirebaseResult<ChatEntity>>(
      FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );
    when(mockRepo.getChatWithMessages(userId, chatId)).thenAnswer(
      (_) async => FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call(userId, chatId);

    expect(result, isA<FirebaseErrorResult<ChatEntity>>());
  });
}
