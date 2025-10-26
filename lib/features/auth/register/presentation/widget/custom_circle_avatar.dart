import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar(this.customIcon, {super.key});
  final IconData customIcon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.secondary,
      child: Icon(customIcon),
    );
  }
}
