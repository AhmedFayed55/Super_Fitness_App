import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/widgets/w_g_a_body.dart';

class WeightGoalActivityEdit extends StatelessWidget {
  const WeightGoalActivityEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.wgaBackground, fit: BoxFit.cover),
          ),

          const WGABody(),
        ],
      ),
    );
  }
}
