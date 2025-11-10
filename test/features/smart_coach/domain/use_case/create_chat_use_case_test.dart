import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/create_chat_use_case.dart';
import 'create_chat_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachRepository, DocumentReference])
void main() {
  late MockSmartCoachRepository mockRepo;
  late CreateChatUseCase useCase;
  late MockDocumentReference mockDoc;

  setUp(() {
    mockRepo = MockSmartCoachRepository();
    mockDoc = MockDocumentReference();
    useCase = CreateChatUseCase(mockRepo);
  });

  test('should call repo.createChat and return success', () async {
    const userId = 'u1';
    const title = 'Chat';
    provideDummy<FirebaseResult<DocumentReference>>(
      FirebaseSuccessResult(data: mockDoc),
    );
    when(
      mockRepo.createChat(userId, title),
    ).thenAnswer((_) async => FirebaseSuccessResult(data: mockDoc));

    final result = await useCase.call(userId, title);

    verify(mockRepo.createChat(userId, title)).called(1);
    expect(result, isA<FirebaseSuccessResult<DocumentReference>>());
  });

  test('should return error when repo fails', () async {
    const userId = 'u1';
    const title = 'Chat';
    provideDummy<FirebaseResult<DocumentReference>>(
      FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );
    when(mockRepo.createChat(userId, title)).thenAnswer(
      (_) async => FirebaseErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call(userId, title);

    expect(result, isA<FirebaseErrorResult<DocumentReference>>());
  });
}
