import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_event.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;

  const OtpInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final viewModel = context.read<ForgetPasswordViewModel>();

    final defaultPinTheme = PinTheme(
      width: width * 0.13,
      height: height * 0.07,
      textStyle: TextStyle(
        fontSize: width * 0.06,
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.primary,
            width: width * 0.002,
          ),
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(
        bottom: BorderSide(
          color: theme.colorScheme.primary,
          width: width * 0.002,
        ),
      ),
    );

    return Pinput(
      controller: controller,
      length: 6,
      keyboardType: TextInputType.number,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: defaultPinTheme,
      showCursor: true,
      onCompleted: (pin) {
        if (pin.length == 6) {

          viewModel.doIntent(VerifyCodeEvent(code: pin));
        }
      },
    );
  }
}
