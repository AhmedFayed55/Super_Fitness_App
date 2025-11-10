import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';

extension MessageEntityMapper on MessageEntity {
  MessageDto toDto() {
    return MessageDto(
      id: id,
      text: text,
      sender: sender,
      timestamp: timestamp.millisecondsSinceEpoch,
    );
  }
}
