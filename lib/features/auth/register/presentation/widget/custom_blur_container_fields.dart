import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_form_register.dart';

class CustomBlurContainerFields extends StatelessWidget {
  const CustomBlurContainerFields({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(screenWidth * .1),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppConstants.blurValueRegister,
          sigmaY: AppConstants.blurValueRegister,
        ),
        child: const IntrinsicHeight(
          child: SizedBox(
            key: Key(AppKeys.blurContainerSizedBox),
            width: double.infinity,
            child: CustomFormRegister(),
          ),
        ),
      ),
    );
  }
}
