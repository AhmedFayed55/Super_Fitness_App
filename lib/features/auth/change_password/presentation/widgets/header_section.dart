import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(AppAssets.appLogo)),
        verticalSpace(58),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: context.localization.make_sure_its_8_characters_or_more,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 18),
                ),
                TextSpan(
                  text: context.localization.create_new_password,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
