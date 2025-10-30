import 'package:super_fitness_app/features/details_food/domain/entities/ingredient_entity.dart';

class DetailsFoodEntity {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;
  final String tags;
  final String youtubeUrl;
  final List<IngredientEntity> ingredients;
  final String sourceUrl;

  DetailsFoodEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
    required this.tags,
    required this.youtubeUrl,
    required this.ingredients,
    required this.sourceUrl,
  });
}
