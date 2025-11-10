import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';

class WGADataWidget extends StatelessWidget {
  const WGADataWidget({
    super.key,
    required this.weight,
    required this.goal,
    required this.activityLevel,
  });
  final int weight;
  final String goal;
  final String activityLevel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    var trans = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _editableLabel(
          context,
          label: trans.your_weight,
          onTap: () {
            cubit.navigatToEditsScreen(Edits.weight);
            context.pushNamed(
              AppRoutes.weightGoalActivityEdit,
              arguments: cubit,
            );
          },
        ),
        verticalSpace(context.mdH(8)),
        _displayField(context, "$weight KG"),

        verticalSpace(context.mdH(16)),

        _editableLabel(
          context,
          label: trans.your_goal,
          onTap: () {
            cubit.navigatToEditsScreen(Edits.goal);
            context.pushNamed(
              AppRoutes.weightGoalActivityEdit,
              arguments: cubit,
            );
          },
        ),
        verticalSpace(context.mdH(8)),
        _displayField(context, goal),

        verticalSpace(context.mdH(16)),

        _editableLabel(
          context,
          label: trans.your_activity_level,
          onTap: () {
            cubit.navigatToEditsScreen(Edits.activity);
            context.pushNamed(
              AppRoutes.weightGoalActivityEdit,
              arguments: cubit,
            );
          },
        ),
        verticalSpace(context.mdH(8)),
        _displayField(context, activityLevel, disabled: true),
      ],
    );
  }

  Widget _editableLabel(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    var trans = context.localization;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label (",
            style: context.textTheme.displaySmall!.copyWith(fontSize: 14),
          ),
          TextSpan(
            text: trans.tap_to_edit,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: context.textTheme.displaySmall!.copyWith(
              fontSize: 14,
              color: context.colorScheme.primary,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          TextSpan(
            text: ")",
            style: context.textTheme.displaySmall!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _displayField(
    BuildContext context,
    String text, {
    bool disabled = false,
  }) {
    final controller = TextEditingController(text: text);

    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: !disabled,
      style: context.textTheme.bodySmall!.copyWith(
        fontWeight: AppFontWeight.bold,
      ),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.grey[90]!),
        ),
        fillColor: context.colorScheme.surface.withValues(alpha: 0.15),
        filled: true,
      ),
    );
  }
}
