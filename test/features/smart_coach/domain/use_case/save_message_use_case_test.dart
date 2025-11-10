import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/save_message_use_case.dart';
import 'save_message_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachRepository])
void main() {
  late MockSmartCoachRepository mockRepo;
  late SaveMessageUseCase useCase;

  setUp(() {
    mockRepo = MockSmartCoachRepository();
    useCase = SaveMessageUseCase(mockRepo);
  });

  test('should call repo.saveMessage and return success', () async {
    const userId = 'u1';
    const chatId = 'c1';
    const text = 'Hello';
    const sender = 'user';
    provideDummy<FirebaseResult<void>>(FirebaseSuccessResult(data: null));
    when(
      mockRepo.saveMessage(
        userId: anyNamed('userId'),
        chatId: anyNamed('chatId'),
        message: anyNamed('message'),
      ),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

    final result = await useCase.call(
      userId: userId,
      chatId: chatId,
      text: text,
      sender: sender,
    );

    verify(
      mockRepo.saveMessage(
        userId: userId,
        chatId: chatId,
        message: anyNamed('message'),
      ),
    ).called(1);
    expect(result, isA<FirebaseSuccessResult<void>>());
  });

  test('should return error when repo fails', () async {
    const userId = 'u1';
    const chatId = 'c1';
    const text = 'Hello';
    const sender = 'user';
    provideDummy<FirebaseResult<void>>(
      FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );
    when(
      mockRepo.saveMessage(
        userId: anyNamed('userId'),
        chatId: anyNamed('chatId'),
        message: anyNamed('message'),
      ),
    ).thenAnswer(
      (_) async => FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call(
      userId: userId,
      chatId: chatId,
      text: text,
      sender: sender,
    );

    expect(result, isA<FirebaseErrorResult<void>>());
  });
}
