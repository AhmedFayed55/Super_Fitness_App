import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final String sender;
  final DateTime timestamp;

  const MessageEntity({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  bool get isUserMessage => sender == 'user';
  bool get isBotMessage => sender == 'bot';

  @override
  List<Object?> get props => [id, text, sender, timestamp];
}
