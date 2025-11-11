import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';

class ChatEntity extends Equatable {
  final String id;
  final String title;
  final DateTime? createdAt;
  final DateTime? lastMessageAt;
  final List<MessageEntity> messages;

  const ChatEntity({
    required this.id,
    required this.title,
    this.createdAt,
    this.lastMessageAt,
    this.messages = const [],
  });

  int get messageCount => messages.length;

  MessageEntity? get lastMessage => messages.isNotEmpty ? messages.last : null;

  @override
  List<Object?> get props => [id, title, createdAt, lastMessageAt, messages];
}
