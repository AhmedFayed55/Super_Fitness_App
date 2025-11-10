import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_metadata_dto.g.dart';

@JsonSerializable()
class ChatMetadataDto {
  final String id;
  final String title;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp? createdAt;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp? lastMessageAt;
  final int messageCount;

  ChatMetadataDto({
    required this.id,
    required this.title,
    this.createdAt,
    this.lastMessageAt,
    this.messageCount = 0,
  });

  factory ChatMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMetadataDtoToJson(this);

  factory ChatMetadataDto.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) {
    return ChatMetadataDto(
      id: docId,
      title: data['title'] as String,
      createdAt: data['createdAt'] as Timestamp?,
      lastMessageAt: data['lastMessageAt'] as Timestamp?,
      messageCount: (data['messages'] as List?)?.length ?? 0,
    );
  }

  static Timestamp? _timestampFromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) return json;
    return null;
  }

  static dynamic _timestampToJson(Timestamp? timestamp) => timestamp;
}
