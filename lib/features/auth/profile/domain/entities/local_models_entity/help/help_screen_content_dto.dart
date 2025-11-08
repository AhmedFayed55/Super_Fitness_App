import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/style_dto.dart';

class HelpScreenContentEntity {
  final String? section;
  final ContentEntity? content;
  final StyleEntity? style;

  HelpScreenContentEntity ({
    this.section,
    this.content,
    this.style,
  });

}