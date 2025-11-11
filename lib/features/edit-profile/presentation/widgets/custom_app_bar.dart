import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';

AppBar customAppBar(BuildContext context) {
  var trans = context.localization;

  return AppBar(
    title: Text(
      trans.edit_profile,
      style: context.textTheme.displayLarge!.copyWith(
        fontWeight: AppFontWeight.semiBold,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.primary,
      ),
      child: IconButton(
        icon: SvgPicture.asset(height: 15, AppAssets.arrowBackIcon),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
