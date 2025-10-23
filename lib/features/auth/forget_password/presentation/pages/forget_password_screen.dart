import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/view/forget_password_view.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordViewModel>(
      create: (context) => getIt.get<ForgetPasswordViewModel>(),
      child: const ForgetPasswordView(),
    );
  }
}
