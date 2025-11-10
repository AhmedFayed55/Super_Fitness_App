import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/details_food/data/models/mapper/details_food_mapper.dart';
import 'package:super_fitness_app/features/details_food/data/models/response/meal_model_dto.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/ingredient_entity.dart';

void main() {
  group('DetailsFoodMapper', () {
    test('should convert MealModelDto to DetailsFoodEntity correctly', () {
      // Arrange
      final json = {
        'idMeal': '52959',
        'strMeal': 'Baked salmon with fennel & tomatoes',
        'strCategory': 'Seafood',
        'strArea': 'British',
        'strInstructions': 'Some instructions',
        'strMealThumb': 'https://example.com/image.jpg',
        'strYoutube': 'https://youtube.com/video',
        'strSource': 'https://example.com/source',
        'strTags': 'Paleo,Keto',
        'strIngredient1': 'Fennel',
        'strMeasure1': '2 medium',
        'strIngredient2': 'Parsley',
        'strMeasure2': '2 tbs',
      };

      final dto = MealModelDto.fromJson(json);
      final entity = dto.toEntity();

      expect(entity.id, '52959');
      expect(entity.name, 'Baked salmon with fennel & tomatoes');
      expect(entity.category, 'Seafood');
      expect(entity.area, 'British');
      expect(entity.instructions, 'Some instructions');
      expect(entity.imageUrl, 'https://example.com/image.jpg');
      expect(entity.youtubeUrl, 'https://youtube.com/video');
      expect(entity.sourceUrl, 'https://example.com/source');
      expect(entity.tags, 'Paleo,Keto');
      expect(entity.ingredients.length, 2);
      expect(entity.ingredients[0], isA<IngredientEntity>());
      expect(entity.ingredients[0].name, 'Fennel');
      expect(entity.ingredients[0].measure, '2 medium');
      expect(entity.ingredients[1].name, 'Parsley');
      expect(entity.ingredients[1].measure, '2 tbs');
    });
  });
}
