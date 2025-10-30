import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import '../../../../../core/helpers/validators.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({super.key, required this.email, required this.password});

  final TextEditingController email;
  final TextEditingController password;

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: context.localization.email,
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
          ),
          validator: (value) => Validations.validateEmail(context, value),
          controller: widget.email,
        ),
        TextFormField(
          obscureText: isObscure,
          validator: (value) => Validations.validatePassword(context, value),
          controller: widget.password,
          decoration: InputDecoration(
            hintText: context.localization.password,
            prefixIcon: const Icon(Icons.lock_open_outlined, size: 20),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              icon: Icon(
                isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
