import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';

abstract interface class SmartCoachRepository {
  Future<ApiResult<GetUserDataResponseEntity>> getUserData();

  Future<FirebaseResult<DocumentReference>> createChat(
    String userId,
    String title,
  );

  Future<FirebaseResult<void>> saveMessage({
    required String userId,
    required String chatId,
    required MessageEntity message,
  });

  Future<FirebaseResult<void>> saveMessagesBatch({
    required String userId,
    required String chatId,
    required List<MessageEntity> messages,
  });

  Future<FirebaseResult<List<ChatMetadataEntity>>> getUserChats(String userId);

  Future<FirebaseResult<ChatEntity>> getChatWithMessages(
    String userId,
    String chatId,
  );

  Future<FirebaseResult<void>> deleteChat(String userId, String chatId);

  Future<FirebaseResult<void>> clearChatMessages(String userId, String chatId);
}
