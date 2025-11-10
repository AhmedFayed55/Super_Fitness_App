import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class ClearChatMessagesUseCase {
  final SmartCoachRepository _repository;

  ClearChatMessagesUseCase(this._repository);

  Future<FirebaseResult<void>> call(String userId, String chatId) {
    return _repository.clearChatMessages(userId, chatId);
  }
}
