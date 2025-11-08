import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/style_dto.dart';

class PrivacyAndSecurityScreenResponseEntity {
  final String? section;
  final ContentEntity? content;
  final StyleEntity? style;

  PrivacyAndSecurityScreenResponseEntity ({
    this.section,
    this.content,
    this.style,
  });

}



