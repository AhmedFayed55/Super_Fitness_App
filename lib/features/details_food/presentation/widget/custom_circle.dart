import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

class CustomCircle extends StatelessWidget {
  const CustomCircle({super.key, required this.name, required this.countyItem});
  final String name;
  final String countyItem;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var color = context.colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.mdRadius(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppConstants.sigmaX,
          sigmaY: AppConstants.sigmaY,
        ),
        child: Container(
          alignment: Alignment.center,
          width: context.mdW(54),
          height: context.mdH(44),
          decoration: BoxDecoration(
            color: color.secondary.withAlpha(0x80),
            border: Border.all(color: color.onSecondary, width: context.mdH(1)),
            borderRadius: BorderRadius.circular(context.mdRadius(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(countyItem, style: theme.bodySmall),
              Text(
                name,
                style: theme.displayMedium!.copyWith(
                  fontSize: 12,
                  color: color.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
