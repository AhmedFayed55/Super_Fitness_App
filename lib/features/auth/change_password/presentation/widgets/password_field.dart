import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_state.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/manager/change_pass_view_model.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isVisible;
  final void Function()? onPressed;
  final String? Function(String?) validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isVisible,
    required this.onPressed,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordViewModel, ChangePasswordState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: isVisible,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: isVisible
                  ? const Icon(Icons.visibility_off_outlined)
                  : const Icon(Icons.visibility_outlined),
            ),
          ),
        );
      },
    );
  }
}
