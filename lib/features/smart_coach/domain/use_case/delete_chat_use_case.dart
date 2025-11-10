import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class DeleteChatUseCase {
  final SmartCoachRepository _repository;

  DeleteChatUseCase(this._repository);

  Future<FirebaseResult<void>> call(String userId, String chatId) {
    return _repository.deleteChat(userId, chatId);
  }
}
