import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_view_model.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var color = context.colorScheme;
    return GestureDetector(
      onTap: () =>
          context.read<RegisterViewModel>().pageController.previousPage(
            duration: const Duration(milliseconds: AppConstants.registerDuration),
            curve: Curves.easeInOut,
          ),
      child: Container(
        width: width * 0.09,
        height: height * 0.06,
        decoration: BoxDecoration(color: color.primary, shape: BoxShape.circle),
        child: Center(
          child: Image.asset(AppAssets.arrow_back, color: color.onPrimary),
        ),
      ),
    );
  }
}
