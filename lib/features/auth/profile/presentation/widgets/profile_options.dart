import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/general_cubits/locale_cubit.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/manager/profile_screen_view_model.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/widgets/profile_tile.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfileScreenViewModel>();
    final AppLocalizations l10n = context.localization;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ProfileTile(
            icon: AppAssets.editProfileIcon,
            title: l10n.edit_profile,
            onTap: () {
              //todo: navigate to edit profile screen
            },
          ),
          ProfileTile(
            icon: AppAssets.changePasswordIcon,
            title: l10n.change_password,
            onTap: () {
              //todo: navigate to change password screen
            },
          ),
          BlocBuilder<LocaleCubit, Locale>(
            builder: (context, localeState) {
              bool isEnglish = localeState.languageCode == AppConstants.enKey;
              return ProfileTile(
                icon: AppAssets.languageIcon,
                title: "${l10n.select_language} (${isEnglish ? l10n.english : l10n.arabic})",
                trailing: Switch(
                  value: isEnglish,
                  onChanged: (val) {
                    context.read<LocaleCubit>().changeLocale();
                  },
                ),
              );
            },
          ),
          ProfileTile(
            icon: AppAssets.securityIcon,
            title: l10n.security,
            onTap: () {
              context.pushNamed(AppRoutes.contentScreen,arguments: ContentType.security);
            },
          ),
          ProfileTile(
            icon: AppAssets.privacyPolicyIcon,
            title: l10n.privacy_policy,
            onTap: () {
              context.pushNamed(AppRoutes.contentScreen,arguments: ContentType.privacy);
            },
          ),
          ProfileTile(
            icon: AppAssets.helpIcon,
            title: l10n.help,
            onTap: () {
              context.pushNamed(AppRoutes.contentScreen,arguments: ContentType.help);
            },
          ),
          ProfileTile(
            icon: AppAssets.logoutIcon,
            title: l10n.logout,
            textColor: context.colorScheme.primary,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}