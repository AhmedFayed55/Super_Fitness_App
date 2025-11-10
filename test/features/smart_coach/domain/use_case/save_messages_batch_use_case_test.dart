import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/save_messages_batch_use_case.dart';
import 'save_messages_batch_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachRepository])
void main() {
  late MockSmartCoachRepository mockRepo;
  late SaveMessagesBatchUseCase useCase;

  setUp(() {
    mockRepo = MockSmartCoachRepository();
    useCase = SaveMessagesBatchUseCase(mockRepo);
  });

  test('should call repo.saveMessagesBatch and return success', () async {
    const userId = 'u1';
    const chatId = 'c1';
    final messages = [
      MessageEntity(
        id: '1',
        text: 'Hi',
        sender: 'user',
        timestamp: DateTime.now(),
      ),
    ];
    provideDummy<FirebaseResult<void>>(FirebaseSuccessResult(data: null));
    when(
      mockRepo.saveMessagesBatch(
        userId: anyNamed('userId'),
        chatId: anyNamed('chatId'),
        messages: anyNamed('messages'),
      ),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

    final result = await useCase.call(
      userId: userId,
      chatId: chatId,
      messages: messages,
    );

    verify(
      mockRepo.saveMessagesBatch(
        userId: userId,
        chatId: chatId,
        messages: anyNamed('messages'),
      ),
    ).called(1);
    expect(result, isA<FirebaseSuccessResult<void>>());
  });

  test('should return error when repo fails', () async {
    const userId = 'u1';
    const chatId = 'c1';
    final messages = [
      MessageEntity(
        id: '1',
        text: 'Hi',
        sender: 'user',
        timestamp: DateTime.now(),
      ),
    ];
    provideDummy<FirebaseResult<void>>(
      FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );
    when(
      mockRepo.saveMessagesBatch(
        userId: anyNamed('userId'),
        chatId: anyNamed('chatId'),
        messages: anyNamed('messages'),
      ),
    ).thenAnswer(
      (_) async => FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call(
      userId: userId,
      chatId: chatId,
      messages: messages,
    );

    expect(result, isA<FirebaseErrorResult<void>>());
  });
}
