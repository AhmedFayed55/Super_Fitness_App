import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/delete_chat_use_case.dart';
import 'delete_chat_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachRepository])
void main() {
  late MockSmartCoachRepository mockRepo;
  late DeleteChatUseCase useCase;

  setUp(() {
    mockRepo = MockSmartCoachRepository();
    useCase = DeleteChatUseCase(mockRepo);
  });

  test('should call repo.deleteChat and return success', () async {
    const userId = 'u1';
    const chatId = 'c1';
    provideDummy<FirebaseResult<void>>(FirebaseSuccessResult(data: null));
    when(
      mockRepo.deleteChat(userId, chatId),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

    final result = await useCase.call(userId, chatId);

    verify(mockRepo.deleteChat(userId, chatId)).called(1);
    expect(result, isA<FirebaseSuccessResult<void>>());
  });

  test('should return error when repo fails', () async {
    const userId = 'u1';
    const chatId = 'c1';
    provideDummy<FirebaseResult<void>>(
      FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );
    when(mockRepo.deleteChat(userId, chatId)).thenAnswer(
      (_) async => FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call(userId, chatId);

    expect(result, isA<FirebaseErrorResult<void>>());
  });
}
