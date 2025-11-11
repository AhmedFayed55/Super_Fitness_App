import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart'
    as privacy;
import 'package:super_fitness_app/features/auth/profile/presentation/widgets/hex_color.dart';
import 'styled_text_widget.dart';

class PrivacyContentBuilder extends StatelessWidget {
  final privacy.PrivacyPolicyEntity entity;

  const PrivacyContentBuilder({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: entity.style?.backgroundColor != null
          ? HexColor.fromHex(entity.style!.backgroundColor!)
          : Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entity.title != null)
            StyledText(text: entity.title!, style: entity.style),
          if (entity.content != null)
            ...entity.content!.map(
              (line) => StyledText(text: line ?? '', style: entity.style),
            ),
          if (entity.subSections != null)
            ...entity.subSections!.map(
              (sub) => PrivacyContentBuilder(entity: sub),
            ),
        ],
      ),
    );
  }
}
