import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_chats_use_case.dart';
import 'get_user_chats_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachRepository])
void main() {
  late MockSmartCoachRepository mockRepo;
  late GetUserChatsUseCase useCase;

  setUp(() {
    mockRepo = MockSmartCoachRepository();
    useCase = GetUserChatsUseCase(mockRepo);
  });

  test('should call repo.getUserChats and return success', () async {
    const userId = 'u1';
    final chats = [
      const ChatMetadataEntity(id: 'c1', title: 'Chat', messageCount: 1),
    ];
    provideDummy<FirebaseResult<List<ChatMetadataEntity>>>(
      FirebaseSuccessResult(data: chats),
    );
    when(
      mockRepo.getUserChats(userId),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: chats));

    final result = await useCase.call(userId);

    verify(mockRepo.getUserChats(userId)).called(1);
    expect(result, isA<FirebaseSuccessResult<List<ChatMetadataEntity>>>());
  });

  test('should return error when repo fails', () async {
    const userId = 'u1';
    provideDummy<FirebaseResult<List<ChatMetadataEntity>>>(
      FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );
    when(mockRepo.getUserChats(userId)).thenAnswer(
      (_) async => FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call(userId);

    expect(result, isA<FirebaseErrorResult<List<ChatMetadataEntity>>>());
  });
}
