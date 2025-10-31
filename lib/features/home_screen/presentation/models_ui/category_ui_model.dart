import 'package:flutter/cupertino.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CategoryModel {
  final String image;
  final String name;

  CategoryModel({required this.image, required this.name});

  static List<CategoryModel> getCategory(BuildContext context) {
    return [
      CategoryModel(
        image: "assets/images/gym.png",
        name: context.localization.gym,
      ),
      CategoryModel(
        image: "assets/images/fitness.png",
        name: context.localization.fitness,
      ),
      CategoryModel(
        image: "assets/images/yoga.png",
        name: context.localization.yoga,
      ),
      CategoryModel(
        image: "assets/images/aerobics.png",
        name: context.localization.aerobics,
      ),
      CategoryModel(
        image: "assets/images/trainer.png",
        name: context.localization.trainer,
      ),
    ];
  }
}
