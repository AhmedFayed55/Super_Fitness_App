import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class GetUserChatsUseCase {
  final SmartCoachRepository _repository;

  GetUserChatsUseCase(this._repository);

  Future<FirebaseResult<List<ChatMetadataEntity>>> call(String userId) {
    return _repository.getUserChats(userId);
  }
}
