import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';

class RecommendationForYou extends StatelessWidget {

  const RecommendationForYou({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final data = state.forYouData?.categoriesDtoEntity ?? [];
        return Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommendation for you",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                InkWell(
                  onTap: () {
                    /// onPressed Recommendation for you
                  },
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(AppRoutes.foodScreen,arguments: {
                        "CategoryName": "",
                        "list": state.forYouData?.categoriesDtoEntity,
                      });
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        color: Color(0xFFFF4100),
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Color(0xFFFF4100),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(8),
            SizedBox(
              height: 104,
              child: ListView.separated(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.pushNamed(AppRoutes.foodScreen,arguments: {
                        "index": index,
                        "list": state.forYouData?.categoriesDtoEntity,
                      });
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: const Color(0xff242424),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:(state.forYouData?.categoriesDtoEntity[index].strCategoryThumb == null ||
                                state.forYouData!.categoriesDtoEntity[index].strCategoryThumb.isEmpty)
                                ? const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            )
                                :
                            Image.network(
                              "${state.forYouData?.categoriesDtoEntity[index].strCategoryThumb}",
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF242424).withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${state.forYouData?.categoriesDtoEntity[index].strCategory}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return horizontalSpace(16);
                },
              ),
            ),
          ],
        ));
      },
    );
  }
}
