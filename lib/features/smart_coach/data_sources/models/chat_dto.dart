import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class ChatDto {
  final String id;
  final String title;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp? createdAt;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp? lastMessageAt;
  final List<MessageDto> messages;
  final int messageCount;

  ChatDto({
    required this.id,
    required this.title,
    this.createdAt,
    this.lastMessageAt,
    this.messages = const [],
    this.messageCount = 0,
  });

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);

  factory ChatDto.fromFirestore(String docId, Map<String, dynamic> data) {
    final messagesList =
        (data['messages'] as List?)
            ?.map(
              (msg) => MessageDto.fromFirestore(msg as Map<String, dynamic>),
            )
            .toList() ??
        [];

    return ChatDto(
      id: docId,
      title: data['title'] as String,
      createdAt: data['createdAt'] as Timestamp?,
      lastMessageAt: data['lastMessageAt'] as Timestamp?,
      messages: messagesList,
      messageCount: messagesList.length,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'createdAt': createdAt,
      'lastMessageAt': lastMessageAt,
      'messages': messages.map((m) => m.toFirestore()).toList(),
    };
  }

  static Timestamp? _timestampFromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) return json;
    return null;
  }

  static dynamic _timestampToJson(Timestamp? timestamp) => timestamp;
}
