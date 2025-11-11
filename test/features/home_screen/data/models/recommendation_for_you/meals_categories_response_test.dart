import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';

void main() {
  group('MealsCategoriesResponse', () {
    test('Test fromJson', () {
      final json = {
        "categories": [
          {
            "idCategory": "1",
            "strCategory": "Category 1",
            "strCategoryThumb": "strCategoryThumb",
            "strCategoryDescription": "Description 1",
          },
          {
            "idCategory": "2",
            "strCategory": "Category 2",
            "strCategoryThumb": "strCategoryThumb",
            "strCategoryDescription": "Description 2",
          },
        ],
      };

      final model = MealsCategoriesResponse.fromJson(json);

      expect(model.categoriesDto?.length, 2);
      expect(model.categoriesDto?[0].idCategory, "1");
      expect(model.categoriesDto?[0].strCategory, "Category 1");
      expect(model.categoriesDto?[0].strCategoryThumb, "strCategoryThumb");
      expect(model.categoriesDto?[0].strCategoryDescription, "Description 1");

      expect(model.categoriesDto?[1].idCategory, "2");
      expect(model.categoriesDto?[1].strCategory, "Category 2");
      expect(model.categoriesDto?[1].strCategoryThumb, "strCategoryThumb");
      expect(model.categoriesDto?[1].strCategoryDescription, "Description 2");
    });

    test('Test toJson', () {
      final model = MealsCategoriesResponse(
        categoriesDto: [
          CategoriesDto(
            idCategory: "1",
            strCategory: "Category 1",
            strCategoryThumb: "strCategoryThumb",
            strCategoryDescription: "Description 1",
          ),
          CategoriesDto(
            idCategory: "2",
            strCategory: "Category 2",
            strCategoryThumb: "strCategoryThumb",
            strCategoryDescription: "Description 2",
          ),
        ],
      );

      final json = model.toJson();

      expect(model.categoriesDto?[0].idCategory, "1");
      expect(model.categoriesDto?[0].strCategory, "Category 1");
      expect(model.categoriesDto?[1].idCategory, "2");
      expect(model.categoriesDto?[1].strCategory, "Category 2");

      expect(json['categories'], isNotNull);
      expect((json['categories'] as List).length, 2);
    });
  });
}
