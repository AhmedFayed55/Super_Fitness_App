import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';

class ProfileScreenAppBar extends StatelessWidget {
  const ProfileScreenAppBar({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      
        Expanded(
          child: Text(
            title ?? context.localization.profile,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.displayLarge!.copyWith(
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ),
        SizedBox(width: context.width * 0.1),
      ],
    );
  }
}
