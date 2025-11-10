import 'package:super_fitness_app/features/smart_coach/data_sources/models/response/get_user_data_response_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/user_dto.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_dto.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_entity.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/chat_metadata_dto.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/chat_metadata_entity.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/message_dto.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/message_entity.dart';

extension GetUserDataResponseMapper on GetUserDataResponseDto {
  GetUserDataResponseEntity toEntity() {
    return GetUserDataResponseEntity(
      message: message ?? 'success',
      user: user?.toEntity() ?? _defaultUser(),
    );
  }

  UserEntity _defaultUser() {
    return const UserEntity(
      id: '',
      firstName: 'Unknown',
      lastName: 'User',
      email: '',
      gender: 'male',
      age: 0,
      weight: 0,
      height: 0,
      activityLevel: 'level1',
      goal: 'Maintain weight',
      photo: '',
      createdAt: '',
    );
  }
}

extension UserDtoMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '',
      firstName: firstName ?? 'Unknown',
      lastName: lastName ?? 'User',
      email: email ?? '',
      gender: gender ?? 'male',
      age: age ?? 0,
      weight: weight ?? 0,
      height: height ?? 0,
      activityLevel: activityLevel ?? 'level1',
      goal: goal ?? 'Maintain weight',
      photo:
          photo ?? 'https://fitness.elevateegy.com/uploads/default-profile.png',
      createdAt: createdAt ?? '',
    );
  }
}

extension ChatDtoMapper on ChatDto {
  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      title: title,
      createdAt: createdAt?.toDate(),
      lastMessageAt: lastMessageAt?.toDate(),
      messages: messages.map((m) => m.toEntity()).toList(),
    );
  }
}

extension ChatMetadataDtoMapper on ChatMetadataDto {
  ChatMetadataEntity toEntity() {
    return ChatMetadataEntity(
      id: id,
      title: title,
      createdAt: createdAt?.toDate(),
      lastMessageAt: lastMessageAt?.toDate(),
      messageCount: messageCount,
    );
  }
}

extension MessageDtoMapper on MessageDto {
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      text: text,
      sender: sender,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }
}
