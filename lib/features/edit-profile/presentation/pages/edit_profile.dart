import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_event.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/custom_app_bar.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/edit_profile_body.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key, required this.user});
  final UserEntity user;

  final viewModel = getIt<EditProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel..doIntant(LoadUserDataEvent(user: user)),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: customAppBar(context),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppAssets.editBackground, fit: BoxFit.cover),
            ),

            const EditProfileBody(),
          ],
        ),
      ),
    );
  }
}
