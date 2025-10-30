import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';

class RecommendationToDay extends StatelessWidget {
  const RecommendationToDay({super.key});

  @override
  Widget build(BuildContext context) {
    // var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recommendation to day",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Container(
                height: 104,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child:
                            (state.todayData?.musclesDtoEntity[index].image == null ||
                                state.todayData!.musclesDtoEntity[index].image.isEmpty)
                                ? const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ) :
                            Image.network(
                              "${state.todayData?.musclesDtoEntity[index].image}",
                            width: 100,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 100,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF242424).withValues(alpha: 0.8),
                            borderRadius: BorderRadiusGeometry.circular(20),
                          ),
                          child: Text(
                            "${state.todayData?.musclesDtoEntity[index].name}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return horizontalSpace(16);
                  },
                  itemCount: 5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
