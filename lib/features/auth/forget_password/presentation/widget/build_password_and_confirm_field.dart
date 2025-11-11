import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/validators.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_event.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';

class BuildPasswordAndConfirmField extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmController;

  const BuildPasswordAndConfirmField({
    super.key,
    required this.passwordController,
    required this.confirmController,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final viewModel = context.read<ForgetPasswordViewModel>();
    final tr = context.localization;

    return BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
      buildWhen: (prev, curr) =>
          prev.isPasswordObscure != curr.isPasswordObscure,
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: passwordController,
              obscureText: state.isPasswordObscure,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                hintText: tr.password,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isPasswordObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      viewModel.doIntent(TogglePasswordVisibilityEvent()),
                ),
              ),
              validator: (value) =>
                  Validations.validatePassword(context, value),
            ),
            SizedBox(height: height * 0.025),
            TextFormField(
              controller: confirmController,
              obscureText: state.isPasswordObscure,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                hintText: tr.confirm_password,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isPasswordObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      viewModel.doIntent(TogglePasswordVisibilityEvent()),
                ),
              ),
              validator: (value) => Validations.validateConfirmPassword(
                context,
                value ?? '',
                passwordController.text,
              ),
            ),
          ],
        );
      },
    );
  }
}
