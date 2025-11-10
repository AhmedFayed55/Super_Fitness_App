import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/firebase_result.dart';

import 'package:super_fitness_app/features/smart_coach/data_sources/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_firebase_ds.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_remote_ds.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@Injectable(as: SmartCoachRepository)
class SmartCoachRepositoryImpl implements SmartCoachRepository {
  final SmartCoachRemoteDs _remoteDataSource;
  final SmartCoachFirebaseDs _firebaseDataSource;

  SmartCoachRepositoryImpl(this._remoteDataSource, this._firebaseDataSource);

  @override
  Future<ApiResult<GetUserDataResponseEntity>> getUserData() async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.getUserData();
      return response.toEntity();
    });
  }

  @override
  Future<FirebaseResult<DocumentReference>> createChat(
    String userId,
    String title,
  ) async {
    return await safeFirebaseCall(() async {
      return await _firebaseDataSource.createChat(userId: userId, title: title);
    });
  }

  @override
  Future<FirebaseResult<void>> saveMessage({
    required String userId,
    required String chatId,
    required MessageEntity message,
  }) async {
    return await safeFirebaseCall(() async {
      final messageDto = message.toDto();
      return await _firebaseDataSource.saveMessage(
        userId: userId,
        chatId: chatId,
        message: messageDto,
      );
    });
  }

  @override
  Future<FirebaseResult<void>> saveMessagesBatch({
    required String userId,
    required String chatId,
    required List<MessageEntity> messages,
  }) async {
    return await safeFirebaseCall(() async {
      final messageDtos = messages.map((m) => m.toDto()).toList();
      return await _firebaseDataSource.saveMessagesBatch(
        userId: userId,
        chatId: chatId,
        messages: messageDtos,
      );
    });
  }

  @override
  Future<FirebaseResult<List<ChatMetadataEntity>>> getUserChats(
    String userId,
  ) async {
    return await safeFirebaseCall(() async {
      final chats = await _firebaseDataSource.getUserChats(userId);
      return chats.map((dto) => dto.toEntity()).toList();
    });
  }

  @override
  Future<FirebaseResult<ChatEntity>> getChatWithMessages(
    String userId,
    String chatId,
  ) async {
    return await safeFirebaseCall(() async {
      final chatDto = await _firebaseDataSource.getChatWithMessages(
        userId: userId,
        chatId: chatId,
      );
      return chatDto.toEntity();
    });
  }

  @override
  Future<FirebaseResult<void>> deleteChat(String userId, String chatId) async {
    return await safeFirebaseCall(() async {
      return await _firebaseDataSource.deleteChat(
        userId: userId,
        chatId: chatId,
      );
    });
  }

  @override
  Future<FirebaseResult<void>> clearChatMessages(
    String userId,
    String chatId,
  ) async {
    return await safeFirebaseCall(() async {
      return await _firebaseDataSource.clearChatMessages(
        userId: userId,
        chatId: chatId,
      );
    });
  }
}
