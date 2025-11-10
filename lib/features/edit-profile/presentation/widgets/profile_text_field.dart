import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  const ProfileTextField({
    super.key,
    this.validator,
    required this.controller,
    required this.icon,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        onChanged(value);
        context.read<EditProfileCubit>().formKey.currentState?.validate();
      },
      validator: validator,
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(prefixIcon: Icon(icon), hintText: hint),
    );
  }
}
