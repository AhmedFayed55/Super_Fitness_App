import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';

void main() {
  group('CategoriesDto', () {
    test('Test CategoriesDto fromJson', () {
      final json = {
        "idCategory": "idCategory",
        "strCategory": "strCategory",
        "strCategoryThumb": "strCategoryThumb",
        "strCategoryDescription": "strCategoryDescription",
      };

      final model = CategoriesDto.fromJson(json);

      expect(model.idCategory, json['idCategory']);
      expect(model.strCategory, json['strCategory']);
      expect(model.strCategoryThumb, json['strCategoryThumb']);
      expect(model.strCategoryDescription, json['strCategoryDescription']);
    });

    test('Test CategoriesDto toJson', () {
      final model = CategoriesDto(
        idCategory: "idCategory",
        strCategory: "strCategory",
        strCategoryThumb: "strCategoryThumb",
        strCategoryDescription: "strCategoryDescription",
      );

      final json = model.toJson();

      expect(json['idCategory'], model.idCategory);
      expect(json['strCategory'], model.strCategory);
      expect(json['strCategoryThumb'], model.strCategoryThumb);
      expect(json['strCategoryDescription'], model.strCategoryDescription);
    });
  });
}
