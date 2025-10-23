import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/validators.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_view_model.dart';

class ContentTextFields extends StatefulWidget {
  const ContentTextFields({super.key});

  @override
  State<ContentTextFields> createState() => _ContentTextFieldsState();
}

class _ContentTextFieldsState extends State<ContentTextFields> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel = context.read<RegisterViewModel>();
    var locale = context.localization;
    final double fieldWidth = MediaQuery.of(context).size.width * 0.1;

    return Padding(
      padding: EdgeInsets.only(left: fieldWidth, right: fieldWidth),
      child: Column(
        spacing: MediaQuery.of(context).size.height * .01,
        children: [
          TextFormField(
            validator: (value) => Validations.validateName(context, value),
            controller: registerViewModel.firstName,
            decoration: InputDecoration(
              hintText: locale.first_name,
              prefixIcon: const Icon(Icons.person_outline_sharp),
            ),
          ),

          TextFormField(
            controller: registerViewModel.lastName,
            validator: (value) => Validations.validateName(context, value),
            decoration: InputDecoration(
              hintText: locale.last_name,
              prefixIcon: const Icon(Icons.person_outline_sharp),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: locale.email,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            controller: registerViewModel.emailController,

            validator: (value) => Validations.validateEmail(context, value),
          ),
          TextFormField(
            controller: registerViewModel.passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              hintText: locale.password,
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            validator: (value) => Validations.validatePassword(context, value),
          ),
        ],
      ),
    );
  }
}
