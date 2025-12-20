import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/hex_color.dart';

class StyledText extends StatelessWidget {
  final String text;
  final dynamic style;

  const StyledText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    TextAlign align = TextAlign.start;

    final styleMap = style as dynamic;
    final value = styleMap?.textAlign?['en'] ?? 'left';

    align = switch (value) {
      'center' => TextAlign.center,
      'right' => TextAlign.right,
      _ => TextAlign.left,
    };

    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: styleMap?.fontSize,
        fontWeight: styleMap?.fontWeight == 'bold'
            ? FontWeight.bold
            : FontWeight.normal,
        color: styleMap?.color != null
            ? HexColor.fromHex(styleMap.color!)
            : Colors.black,
        backgroundColor: styleMap?.backgroundColor != null
            ? HexColor.fromHex(styleMap.backgroundColor!)
            : null,
      ),
    );
  }
}
