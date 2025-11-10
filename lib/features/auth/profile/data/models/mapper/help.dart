import 'package:super_fitness_app/features/auth/profile/data/models/local_models_dto/help/help_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';

extension HelpScreenMapper on HelpScreenResponseDto {
  HelpScreenResponseEntity toEntity() => HelpScreenResponseEntity(
    section: section,
    title: title?.en,
    content: content?.en,
    style: style?.toEntity(),
    contacts: contentList?.map((e) => e.toEntity()).toList(),
    faqs: faqs?.map((e) => e.toEntity()).toList(),
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

extension ContactMapper on ContactDto {
  ContactEntity toEntity() => ContactEntity(
    id: id,
    method: method?.en,
    details: details?.en,
    value: value,
    style: style?.toEntity(),
  );
}

extension ContactStyleMapper on ContactStyleDto {
  ContactStyleEntity toEntity() => ContactStyleEntity(
    method: method?.toEntity(),
    details: details?.toEntity(),
  );
}

extension FaqMapper on FaqDto {
  FaqEntity toEntity() =>
      FaqEntity(id: id, question: question?.en, answer: answer?.en);
}
