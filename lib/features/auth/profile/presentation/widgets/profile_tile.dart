import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';

class ProfileTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? textColor;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        height: context.mdH(20),
        width: context.mdW(20),
        colorFilter: ColorFilter.mode(
          context.colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: context.textTheme.labelMedium?.copyWith(
          fontWeight: AppFontWeight.semiBold,
        ),
      ),
      trailing:
          trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: context.colorScheme.primary,
          ),
      onTap: onTap,
    );
  }
}
