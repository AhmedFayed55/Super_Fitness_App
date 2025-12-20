import 'package:super_fitness_app/features/profile/data/models/local_models_dto/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';

extension PrivacyPolicyMapper on PrivacyPolicyResponseDto {
  PrivacyPolicyEntity toEntity() => PrivacyPolicyEntity(
    section: section,
    title: title != null
        ? (title!.en is String
              ? title!.en as String
              : (title!.en is List ? (title!.en as List).join("\n") : null))
        : null,
    content: content
        ?.map(
          (e) => e.en is String
              ? e.en as String
              : e.en is List
              ? (e.en as List).join("\n")
              : null,
        )
        .toList(),
    style: style?.toEntity(),
    subSections: subSections?.map((e) => e.toEntity()).toList(),
  );
}

extension StyleMapper on StyleDto {
  StyleEntity toEntity() => StyleEntity(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    textAlign: textAlign,
    backgroundColor: backgroundColor,
  );
}
