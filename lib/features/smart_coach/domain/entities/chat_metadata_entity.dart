import 'package:equatable/equatable.dart';

class ChatMetadataEntity extends Equatable {
  final String id;
  final String title;
  final DateTime? createdAt;
  final DateTime? lastMessageAt;
  final int messageCount;

  const ChatMetadataEntity({
    required this.id,
    required this.title,
    this.createdAt,
    this.lastMessageAt,
    this.messageCount = 0,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    createdAt,
    lastMessageAt,
    messageCount,
  ];
}
