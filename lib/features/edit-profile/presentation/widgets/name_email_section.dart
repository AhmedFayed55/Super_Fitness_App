import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/helpers/validators.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_event.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/profile_text_field.dart';

class NameEmailSection extends StatefulWidget {
  final UserEntity user;
  const NameEmailSection({super.key, required this.user});

  @override
  State<NameEmailSection> createState() => _NameEmailSectionState();
}

class _NameEmailSectionState extends State<NameEmailSection> {
  late TextEditingController firstController;
  late TextEditingController lastController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstController = TextEditingController(text: widget.user.firstName);
    lastController = TextEditingController(text: widget.user.lastName);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    firstController.dispose();
    lastController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var trans = context.localization;

    var cubit = context.read<EditProfileCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          ProfileTextField(
            validator: (v) => Validations.validateName(context, v),
            controller: firstController,
            icon: Icons.person_2_outlined,
            hint: trans.first_name,
            onChanged: (v) =>
                cubit.doIntant(ChangeFirstNameEvent(newFirstName: v)),
          ),
          verticalSpace(context.mdH(16)),
          ProfileTextField(
            validator: (v) => Validations.validateName(context, v),
            controller: lastController,
            icon: Icons.person_2_outlined,
            hint: trans.last_name,
            onChanged: (v) =>
                cubit.doIntant(ChangeLastNameEvent(newLastName: v)),
          ),
          verticalSpace(context.mdH(16)),
          ProfileTextField(
            validator: (v) => Validations.validateEmail(context, v),
            controller: emailController,
            icon: Icons.email_outlined,
            hint: trans.email,
            onChanged: (v) => cubit.doIntant(ChangeEmailEvent(email: v)),
          ),
        ],
      ),
    );
  }
}
