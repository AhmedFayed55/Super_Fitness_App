import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';

class UserProfile extends StatelessWidget {
  final UserDataResponseEntity? user;

  const UserProfile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Skeletonizer(
            enabled: state.isLoadingImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${context.localization.hi} ${state.userData?.firstName}",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      context.localization.lets_start_your_day,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                Skeleton.leaf(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(state.userData?.photo ?? ""),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
