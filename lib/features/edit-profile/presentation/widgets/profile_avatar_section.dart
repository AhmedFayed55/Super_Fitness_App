import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';

class ProfileAvatarSection extends StatelessWidget {
  final UserEntity user;
  const ProfileAvatarSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.mdH(100),
          width: context.mdH(100),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.photo,
                    width: context.mdH(100),
                    height: context.mdH(100),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: context.mdH(100),
                      height: context.mdH(100),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: context.mdH(100),
                      height: context.mdH(100),
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.error,
                        size: 28,
                        color: context.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 1,
                right: 1,
                child: SizedBox(
                  height: context.mdH(20),
                  width: context.mdH(20),
                  child: SvgPicture.asset(AppAssets.edit),
                ),
              ),
            ],
          ),
        ),

        verticalSpace(context.mdH(20)),

        Text(
          "${user.firstName} ${user.lastName}",
          style: context.textTheme.displayMedium!.copyWith(
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      ],
    );
  }
}
