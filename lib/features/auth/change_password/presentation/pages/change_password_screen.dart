import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/header_section.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/widgets/password_form_section.dart';

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
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [HeaderSection(), PasswordFormSection()],
          ),
        ),
      ),
    );
  }
}
