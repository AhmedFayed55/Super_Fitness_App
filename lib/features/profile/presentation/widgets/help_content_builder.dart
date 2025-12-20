import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart'
    as help;
import 'package:super_fitness_app/features/profile/presentation/widgets/hex_color.dart';
import 'styled_text_widget.dart';

class HelpContentBuilder extends StatelessWidget {
  final help.HelpScreenResponseEntity entity;

  const HelpContentBuilder({super.key, required this.entity});

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
            StyledText(text: entity.content!, style: entity.style),
          if (entity.contacts != null)
            ...entity.contacts!.map(
              (c) => StyledText(text: c.method ?? '', style: c.style?.method),
            ),
          if (entity.faqs != null)
            ...entity.faqs!.map(
              (f) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText(
                    text: f.question ?? '',
                    style: help.StyleEntity(fontWeight: "bold"),
                  ),
                  StyledText(text: f.answer ?? '', style: null),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
