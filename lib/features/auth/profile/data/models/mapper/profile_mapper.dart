import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/style_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/common/text_align_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/help/help_screen_content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/logged_user_data/user_data_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/style_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/text_align_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/help/help_screen_content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';

extension UserDataResponseDtoMapper on UserDataResponseDto {
  UserDataResponseEntity toEntity() {
    if (id == null || email == null) {
      throw Exception("Missing essential user data");
    }

    return UserDataResponseEntity(
      id: id!,
      firstName: firstName ?? "Unknown",
      gender: gender ?? "unspecified",
      createdAt: createdAt ?? "",
      activityLevel: activityLevel ?? "low",
      height: height ?? 0,
      weight: weight ?? 0,
      goal: goal ?? "",
      age: age ?? 0,
      lastName: lastName ?? "Unknown",
      email: email!,
      photo: photo ?? "",
    );
  }
}

extension TextAlignMapper on TextAlignDto {
  TextAlignEntity toEntity() => TextAlignEntity(
    en: en,
    ar: ar,
  );
}

extension ContentMapper on ContentDto {
  ContentEntity toEntity() => ContentEntity(
    en: en,
    ar: ar,
  );
}

extension StyleMapper on StyleDto {
  StyleEntity toEntity() => StyleEntity(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    textAlign: textAlign?.toEntity(),
    backgroundColor: backgroundColor,
  );
}

extension HelpScreenContentMapper on HelpScreenContentDto {
  HelpScreenContentEntity toEntity() => HelpScreenContentEntity(
    section: section,
    content: content?.toEntity(),
    style: style?.toEntity(),
  );
}

extension PrivacyAndSecurityScreenMapper on PrivacyAndSecurityScreenResponseDto {
  PrivacyAndSecurityScreenResponseEntity toEntity() =>
      PrivacyAndSecurityScreenResponseEntity(
        section: section,
        content: content?.toEntity(),
        style: style?.toEntity(),
      );
}

extension SecurityRolesConfigMapper on SecurityRolesConfigResponseDto {
  SecurityRolesConfigResponseEntity toEntity() =>
      SecurityRolesConfigResponseEntity(
        section: section,
        content: content?.toEntity(),
        style: style?.toEntity(),
      );
}
