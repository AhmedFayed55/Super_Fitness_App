import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';
import 'package:super_fitness_app/core/helpers/flutter_toast.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_event.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/profile_avatar_section.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/name_email_section.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/w_g_a_data_widget.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    var trans = context.localization;

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          DialogueUtils.showAlertDialog(context, state.errorMessage);
        }
        if (state.isSuccess) {
          ToastMessage.toastMsg(trans.success, backgroundColor: Colors.green);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final user = state.user!;
        final viewModel = context.read<EditProfileCubit>();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(context.mdH(40)),

                  ProfileAvatarSection(user: user),

                  verticalSpace(context.mdH(20)),

                  NameEmailSection(user: user),

                  verticalSpace(context.mdH(50)),

                  WGADataWidget(
                    weight: user.weight,
                    goal: user.goal,
                    activityLevel: user.activityLevel,
                  ),

                  verticalSpace(context.mdH(24)),

                  CustomElevatedButton(
                    onPressed: viewModel.canSave
                        ? () {
                            viewModel.doIntant(EditProfileDataEvent());
                          }
                        : null,
                    isLoading: state.isLoading,
                    widget: Text(trans.save),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
