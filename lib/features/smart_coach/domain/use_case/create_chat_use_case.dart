import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class CreateChatUseCase {
  final SmartCoachRepository _repository;

  CreateChatUseCase(this._repository);

  Future<FirebaseResult<DocumentReference>> call(String userId, String title) {
    return _repository.createChat(userId, title);
  }
}
