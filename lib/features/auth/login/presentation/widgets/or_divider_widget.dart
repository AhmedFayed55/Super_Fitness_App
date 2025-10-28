import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 50,
            thickness: 2,
            endIndent: 20,
            color: colors.outline,
          ),
        ),
        Text(context.localization.or, style: context.textTheme.bodyMedium),
        Expanded(
          child: Divider(
            thickness: 2,
            indent: 20,
            endIndent: 50,
            color: colors.outline,
          ),
        ),
      ],
    );
  }
}
