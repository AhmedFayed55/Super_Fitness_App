import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/profile/presentation/manager/profile_screen_state.dart';
import 'package:super_fitness_app/features/profile/presentation/manager/profile_screen_view_model.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/profile_options.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/user_photo_and_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = context.height;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.profileBackground,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: height * 0.049,
              ),
              child: Column(
                children: [
                  const ProfileScreenAppBar(),
                  verticalSpace(height * 0.05),
                  BlocBuilder<ProfileScreenViewModel, ProfileScreenState>(
                    builder: (context, state) {
                      if (state.userData != null) {
                        return UserPhotoAndName(user: state.userData!);
                      } else if (state.userDataErrorMsg != null) {
                        return Text(state.userDataErrorMsg!);
                      } else {
                        return CircularProgressIndicator(
                          color: context.colorScheme.primary,
                        );
                      }
                    },
                  ),
                  verticalSpace(height * 0.05),
                  const ProfileOptions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
