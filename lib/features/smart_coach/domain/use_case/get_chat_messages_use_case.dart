import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class GetChatWithMessagesUseCase {
  final SmartCoachRepository _repository;

  GetChatWithMessagesUseCase(this._repository);

  Future<FirebaseResult<ChatEntity>> call(String userId, String chatId) {
    return _repository.getChatWithMessages(userId, chatId);
  }
}
