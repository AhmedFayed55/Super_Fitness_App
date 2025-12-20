import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/profile/presentation/manager/profile_screen_event.dart';
import 'package:super_fitness_app/features/profile/presentation/manager/profile_screen_state.dart';
import 'package:super_fitness_app/features/profile/presentation/manager/profile_screen_view_model.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/help_content_builder.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/privacy_content_builder.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/security_content_builder.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key, required this.type});

  final ContentType type;

  @override
  Widget build(BuildContext context) {
    final height = context.height;

    return BlocProvider(
      create: (context) =>
          getIt<ProfileScreenViewModel>()..doIntent(switch (type) {
            ContentType.privacy => LoadPrivacyContentEvent(),
            ContentType.security => LoadSecurityContentEvent(),
            ContentType.help => LoadHelpContentEvent(),
          }),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.profileBackground,
                fit: BoxFit.cover,
              ),
            ),
            BlocBuilder<ProfileScreenViewModel, ProfileScreenState>(
              builder: (context, state) {
                if (state.isLoadingContent) {
                  return const CircularProgressIndicator();
                }

                if (state.contentErrorMsg != null) {
                  return Center(
                    child: Text(
                      context.localization.something_went_wrong,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                final contentList = switch (type) {
                  ContentType.help => state.helpContent,
                  ContentType.privacy => state.privacyContent,
                  ContentType.security => state.securityContent,
                };

                if (contentList == null || contentList.isEmpty) {
                  return Center(child: Text(context.localization.no_content));
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: height * 0.049,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileScreenAppBar(title: "${type.name} Screen"),
                      verticalSpace(height * 0.03),

                      switch (type) {
                        ContentType.help => Column(
                          children: [
                            for (final item in state.helpContent!)
                              HelpContentBuilder(entity: item),
                          ],
                        ),
                        ContentType.privacy => Column(
                          children: [
                            for (final item in state.privacyContent!)
                              PrivacyContentBuilder(entity: item),
                          ],
                        ),
                        ContentType.security => Column(
                          children: [
                            for (final item in state.securityContent!)
                              SecurityContentBuilder(entity: item),
                          ],
                        ),
                      },
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
