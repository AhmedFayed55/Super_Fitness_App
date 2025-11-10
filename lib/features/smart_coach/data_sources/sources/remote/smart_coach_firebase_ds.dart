import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_metadata_dto.dart';

abstract interface class SmartCoachFirebaseDs {
  Future<DocumentReference> createChat({
    required String userId,
    required String title,
  });

  Future<void> saveMessage({
    required String userId,
    required String chatId,
    required MessageDto message,
  });

  Future<void> saveMessagesBatch({
    required String userId,
    required String chatId,
    required List<MessageDto> messages,
  });

  Future<List<ChatMetadataDto>> getUserChats(String userId);

  Future<ChatDto> getChatWithMessages({
    required String userId,
    required String chatId,
  });

  Future<void> deleteChat({required String userId, required String chatId});

  Future<void> clearChatMessages({
    required String userId,
    required String chatId,
  });
}
