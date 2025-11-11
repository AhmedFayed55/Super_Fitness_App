import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_blur_container_fields.dart';

class CustomMainRegister extends StatelessWidget {
  const CustomMainRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: context.height * .02),
            child: Text(
              context.localization.hey_there,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: context.height * .01,
              left: context.height * .02,
            ),
            child: Text(
              context.localization.create_an_account,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const CustomBlurContainerFields(),
        ],
      ),
    );
  }
}
