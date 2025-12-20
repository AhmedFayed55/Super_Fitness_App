import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';

import '../../../profile/domain/entities/logged_user_data/user_data_response_entity.dart';

class UserProfile extends StatefulWidget {
  final UserDataResponseEntity? user;
  const UserProfile({super.key, this.user});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var screenWidth = context.width;
    // var screenHeight = context.height;
    var cubit = context.read<HomeCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Skeletonizer(
        enabled: _isLoading,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${context.localization.hi} ${cubit.state.userData?.firstName ?? ""} ,\n",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      TextSpan(
                        text: context.localization.lets_start_your_day,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(cubit.state.userData?.photo ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
