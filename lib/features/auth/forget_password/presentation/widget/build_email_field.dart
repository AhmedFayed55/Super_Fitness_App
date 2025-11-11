import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/validators.dart';

class BuildEmailField extends StatelessWidget {
  final TextEditingController controller;
  final BuildContext context;

  const BuildEmailField({
    super.key,
    required this.controller,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final tr = context.localization;

    return TextFormField(
      controller: controller,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        hintText: tr.email,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.email_outlined),
        contentPadding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.02,
        ),
        errorMaxLines: 2,
      ),
      validator: (value) => Validations.validateEmail(context, value),
    );
  }
}
