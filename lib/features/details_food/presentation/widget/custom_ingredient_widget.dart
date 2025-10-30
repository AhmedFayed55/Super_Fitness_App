import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_blur_container.dart';

class CustomIngredientWidget extends StatelessWidget {
  const CustomIngredientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var color = context.colorScheme;
    var locale = context.localization;
    var cubit = context.read<DetailsFoodViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.mdH(20),
        horizontal: context.mdW(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.mdH(10)),
            child: Text(locale.ingredients, style: theme.displayMedium),
          ),
          CustomBlurContainer(
            radiusValue: context.mdRadius(20),
            height: context.mdH(166),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.mdH(10),
                horizontal: context.mdW(10),
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount:
                    cubit.state.detailsFoodEntity?.ingredients.length ?? 0,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: context.mdW(5),
                    right: context.mdW(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cubit.state.detailsFoodEntity?.ingredients[index].name??'uuuu',
                        style: theme.displaySmall,
                      ),
                      Text(
                        cubit
                            .state
                            .detailsFoodEntity
                            ?.ingredients[index]
                            .measure??'',

                        style: theme.titleSmall!.copyWith(color: color.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
