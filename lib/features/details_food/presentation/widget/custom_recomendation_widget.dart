import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CustomRecommendationWidget extends StatelessWidget {
  const CustomRecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [Text(locale.recommendation, style: theme.displayMedium)],
    );
  }
}
