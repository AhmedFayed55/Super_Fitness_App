import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/core/utils/keys.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/content_text_fields.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_circle_avatar.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/register_actions.dart';

class CustomFormRegister extends StatefulWidget {
  const CustomFormRegister({super.key});

  @override
  State<CustomFormRegister> createState() => _CustomFormRegisterState();
}

class _CustomFormRegisterState extends State<CustomFormRegister> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var color = context.colorScheme;
    var width = context.width;
    var height = context.height;
    return Padding(
      padding: EdgeInsetsGeometry.all(width * .03),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: height * .015,
            children: [
              Text(
                key: const Key(AppKeys.registerButton),
                locale.register,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 24),
              ),
              const ContentTextFields(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: width * .02),
                    child: SizedBox(
                      width: width * 0.25,
                      child: Divider(color: color.onPrimary),
                    ),
                  ),
                  Text(locale.or, style: TextStyle(color: color.onPrimary)),
                  Padding(
                    padding: EdgeInsets.only(left: width * .02),
                    child: SizedBox(
                      width: width * 0.25,
                      child: Divider(color: color.onPrimary),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: context.width * .05,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CustomCircleAvatar(FontAwesomeIcons.facebookF),
                  CustomCircleAvatar(FontAwesomeIcons.google),

                  CustomCircleAvatar(FontAwesomeIcons.apple),
                ],
              ),
              RegisterActions(
                onTapRegister: () {
                  if (formKey.currentState!.validate()) {
                    context.read<RegisterViewModel>().pageController.nextPage(
                      duration: const Duration(milliseconds: AppConstants.registerDuration),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
