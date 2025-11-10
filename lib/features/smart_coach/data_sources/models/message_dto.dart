import 'package:json_annotation/json_annotation.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  final String id;
  final String text;
  final String sender; // 'user' or 'bot'
  final int timestamp;

  MessageDto({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

  factory MessageDto.fromFirestore(Map<String, dynamic> data) {
    return MessageDto(
      id: data['id'] as String,
      text: data['text'] as String,
      sender: data['sender'] as String,
      timestamp: data['timestamp'] as int,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'id': id, 'text': text, 'sender': sender, 'timestamp': timestamp};
  }
}
