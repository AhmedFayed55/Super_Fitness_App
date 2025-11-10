import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class SaveMessageUseCase {
  final SmartCoachRepository _repository;

  SaveMessageUseCase(this._repository);

  Future<FirebaseResult<void>> call({
    required String userId,
    required String chatId,
    required String text,
    required String sender,
  }) {
    final message = MessageEntity(
      id: '${DateTime.now().millisecondsSinceEpoch}_$sender',
      text: text,
      sender: sender,
      timestamp: DateTime.now(),
    );

    return _repository.saveMessage(
      userId: userId,
      chatId: chatId,
      message: message,
    );
  }
}
