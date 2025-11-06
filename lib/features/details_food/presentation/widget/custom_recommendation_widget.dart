import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_recommendation_card.dart';

class CustomRecommendationWidget extends StatelessWidget {
  const CustomRecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var locale = context.localization;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mdW(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.mdH(10)),
            child: Text(locale.recommendation, style: theme.displayMedium),
          ),
          SizedBox(
            height: context.mdH(150),
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  horizontalSpace(context.mdW(10)),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  const CustomRecommendationCard(title: 'yahya', imagePath: ''),
            ),
          ),
        ],
      ),
    );
  }
}
