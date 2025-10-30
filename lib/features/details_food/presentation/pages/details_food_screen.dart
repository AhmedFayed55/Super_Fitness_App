// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:super_fitness_app/core/di/di.dart';
// import 'package:super_fitness_app/core/utils/assets.dart';
// import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_event.dart';
// import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
// import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
// import 'package:super_fitness_app/features/details_food/presentation/widget/custom_ingredient_widget.dart';
// import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_widget.dart';

// class DetailsFoodScreen extends StatelessWidget {
//   const DetailsFoodScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           getIt<DetailsFoodViewModel>()..doIntent(DetailsDataFoodEvent(idMeal: '52959'))
//             ,
//       child: SafeArea(
//         child: BlocListener<DetailsFoodViewModel,DetailsFoodState>(listener: (context, state) {
//           if(state.isLoading){
//             Center(child: ,)
//           }

//         },
//           child: Scaffold(
//             body: Stack(
//               children: [
//                 Positioned.fill(child: Image.asset(AppAssets.bgDetailsFood)),
//                  Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [VideoPlayerWidget(), CustomIngredientWidget()],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_event.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_ingredient_widget.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_widget.dart';

class DetailsFoodScreen extends StatelessWidget {
  const DetailsFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DetailsFoodViewModel>()
        ..doIntent(DetailsDataFoodEvent(idMeal: '52959')),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<DetailsFoodViewModel, DetailsFoodState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage.isNotEmpty) {
                return const Center(child: Text("Error loading data"));
              }

              final meal = state.detailsFoodEntity;

              if (meal == null) {
                return const Center(child: Text("No data"));
              }

              return Stack(
                children: [
                  Positioned.fill(child: Image.asset(AppAssets.bgDetailsFood)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VideoPlayerWidget(),
                      CustomIngredientWidget(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          meal.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
