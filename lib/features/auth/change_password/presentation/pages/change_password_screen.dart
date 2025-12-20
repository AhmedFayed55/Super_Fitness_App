import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/header_section.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/password_form_section.dart';
import 'package:super_fitness_app/features/profile/presentation/widgets/profile_app_bar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ChangePasswordViewModel>(),
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.changePasswordBackground),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.042,
                  vertical: context.height * .0197,
                ),
                child: ProfileScreenAppBar(
                  title: context.localization.change_password,
                ),
              ),
              verticalSpace(context.height * 0.049),
              const HeaderSection(),
              const PasswordFormSection(),
            ],
          ),
        ),
      ),
    );
  }
}
