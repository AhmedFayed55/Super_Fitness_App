import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/widgets/activity_blocbuilder.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key});

  final registerViewModel = getIt.get<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
    return BlocProvider(
      create: (context) => registerViewModel,
      child: BlocListener<RegisterViewModel, RegisterState>(
        listener: (context, state) {
          /// activity Listener
        },
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AppAssets.background),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(screenHeight * 0.020),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.043),
                  child: Text(
                    context.localization.your_regular_physical_activity_level,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                verticalSpace(screenHeight * 0.020),
                const ActivityBlocBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
