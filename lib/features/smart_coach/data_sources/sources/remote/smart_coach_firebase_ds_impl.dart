import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/services/firebase_services.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_metadata_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_firebase_ds.dart';

@Injectable(as: SmartCoachFirebaseDs)
class SmartCoachFirebaseDsImpl implements SmartCoachFirebaseDs {
  final FirebaseService _service;

  SmartCoachFirebaseDsImpl(this._service);

  @override
  Future<DocumentReference> createChat({
    required String userId,
    required String title,
  }) async {
    final userDocPath = 'users/$userId/chats';
    final newDoc = FirebaseFirestore.instance.collection(userDocPath).doc();

    await _service.addData(userDocPath, newDoc.id, {
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
      'messages': [],
      'lastMessageAt': FieldValue.serverTimestamp(),
    });

    return newDoc;
  }

  @override
  Future<void> saveMessage({
    required String userId,
    required String chatId,
    required MessageDto message,
  }) async {
    final chatPath = 'users/$userId/chats';

    await FirebaseFirestore.instance.collection(chatPath).doc(chatId).update({
      'messages': FieldValue.arrayUnion([message.toFirestore()]),
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> saveMessagesBatch({
    required String userId,
    required String chatId,
    required List<MessageDto> messages,
  }) async {
    final chatPath = 'users/$userId/chats';

    final messagesData = messages.map((msg) => msg.toFirestore()).toList();

    await FirebaseFirestore.instance.collection(chatPath).doc(chatId).update({
      'messages': FieldValue.arrayUnion(messagesData),
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<List<ChatMetadataDto>> getUserChats(String userId) async {
    final query = await FirebaseFirestore.instance
        .collection('users/$userId/chats')
        .orderBy('lastMessageAt', descending: true)
        .get();

    return query.docs
        .map((doc) => ChatMetadataDto.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  @override
  Future<ChatDto> getChatWithMessages({
    required String userId,
    required String chatId,
  }) async {
    final doc = await FirebaseFirestore.instance
        .collection('users/$userId/chats')
        .doc(chatId)
        .get();

    if (!doc.exists) {
      throw Exception('Chat not found');
    }

    return ChatDto.fromFirestore(doc.id, doc.data()!);
  }

  @override
  Future<void> deleteChat({
    required String userId,
    required String chatId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users/$userId/chats')
        .doc(chatId)
        .delete();
  }

  @override
  Future<void> clearChatMessages({
    required String userId,
    required String chatId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users/$userId/chats')
        .doc(chatId)
        .update({
          'messages': [],
          'lastMessageAt': FieldValue.serverTimestamp(),
        });
  }
}
