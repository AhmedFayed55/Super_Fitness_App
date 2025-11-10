import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class SaveMessagesBatchUseCase {
  final SmartCoachRepository _repository;

  SaveMessagesBatchUseCase(this._repository);

  Future<FirebaseResult<void>> call({
    required String userId,
    required String chatId,
    required List<MessageEntity> messages,
  }) {
    return _repository.saveMessagesBatch(
      userId: userId,
      chatId: chatId,
      messages: messages,
    );
  }
}
