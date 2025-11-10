import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart' as security;
import 'package:super_fitness_app/features/auth/profile/presentation/widgets/hex_color.dart';
import 'styled_text_widget.dart';

class SecurityContentBuilder extends StatelessWidget {
  final security.SecurityRolesConfigEntity entity;

  const SecurityContentBuilder({super.key, required this.entity});

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
          if (entity.title != null) StyledText(text: entity.title!, style: entity.style),
          if (entity.content != null) StyledText(text: entity.content!, style: entity.style),
          if (entity.permissions != null)
            ...entity.permissions!.map(
                  (p) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText(text: p.name ?? '', style: security.StyleEntity(fontWeight: "bold")),
                  StyledText(text: p.description ?? '', style: null),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
