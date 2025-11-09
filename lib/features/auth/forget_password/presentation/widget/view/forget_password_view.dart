import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/forget_password_email_page.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/forget_password_otp_page.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/widget/forget_password_reset_page.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
      listener: (context, state) {
        if (state.isVerifyCodeSent && !state.loading.isVerifyCodeSentLoading) {
          pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: AppConstants.animateSeconds),
            curve: Curves.easeInOut,
          );
        }
        if (state.isOtpCorrect && !state.loading.isOtpCorrectLoading) {
          pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: AppConstants.animateSeconds),
            curve: Curves.easeInOut,
          );
        }
        if (state.isPasswordReset && !state.loading.isPasswordResetLoading) {
          context.pushNamed(AppRoutes.login);
        }
      },
      child: Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ForgetPasswordEmailPage(),
            ForgetPasswordOtpPage(),
            ForgetPasswordResetPage(),
          ],
        ),
      ),
    );
  }
}
