import 'package:super_fitness_app/features/details_food/data/models/response/meal_model_dto.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/ingredient_entity.dart';

extension DetailsFoodMapper on MealModelDto {
  DetailsFoodEntity toEntity() {
    final ingredientsList = <IngredientEntity>[];
    for (int i = 1; i <= 20; i++) {
      final ingredient = _getFieldValue('strIngredient$i') as String?;
      final measure = _getFieldValue('strMeasure$i') as String?;

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredientsList.add(
          IngredientEntity(
            name: ingredient.trim(),
            measure: (measure ?? '').trim(),
          ),
        );
      }
    }

    return DetailsFoodEntity(
      id: idMeal ?? '',
      name: strMeal ?? 'no name',
      category: strCategory ?? '',
      area: strArea ?? 'not found area',
      instructions: strInstructions ?? 'not found instructions',
      imageUrl: strMealThumb ?? '',
      tags: strTags ?? '',
      youtubeUrl: strYoutube ?? '',
      sourceUrl: strSource ?? '',
      ingredients: ingredientsList,
    );
  }

  dynamic _getFieldValue(String fieldName) {
    final map = toJson();
    return map[fieldName];
  }
}
