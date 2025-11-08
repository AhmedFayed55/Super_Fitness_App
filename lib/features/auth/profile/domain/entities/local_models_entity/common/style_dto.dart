import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/common/text_align_dto.dart';

class StyleEntity {
  final int? fontSize;
  final String? fontWeight;
  final String? color;
  final TextAlignEntity? textAlign;
  final String? backgroundColor;

  StyleEntity ({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });
}