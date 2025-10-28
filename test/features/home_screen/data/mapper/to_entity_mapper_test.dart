import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';

void main() {
  group("Test convert from Dto to Entity", () {
    test("CategoriesDtoMapper", () {
      // Arrange
      final dto = CategoriesDto(
        idCategory: 'idCategory',
        strCategory: 'strCategory',
        strCategoryThumb: 'strCategoryThumb',
        strCategoryDescription: 'strCategoryDescription',
      );

      // Act
      final entity = dto.toEntity();

      // Assert
      expect(entity, isA<CategoriesDtoEntity>());
      expect(entity.idCategory, dto.idCategory);
      expect(entity.strCategory, dto.strCategory);
      expect(entity.strCategoryThumb, dto.strCategoryThumb);
      expect(entity.strCategoryDescription, dto.strCategoryDescription);
    });

    test("MealsCategoriesResponseMapper", () {
      // Arrange
      final response = MealsCategoriesResponse(
        categoriesDto: [
          CategoriesDto(
            idCategory: 'idCategory',
            strCategory: 'strCategory',
            strCategoryThumb: 'strCategoryThumb',
            strCategoryDescription: 'strCategoryDescription',
          ),
        ],
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity, isA<MealsCategoriesEntity>());
      expect(entity.categoriesDtoEntity, isNotEmpty);
      expect(
        entity.categoriesDtoEntity.first.idCategory,
        response.categoriesDto?.first.idCategory,
      );
      expect(
        entity.categoriesDtoEntity.first.strCategory,
        response.categoriesDto?.first.strCategory,
      );
      expect(
        entity.categoriesDtoEntity.first.strCategoryThumb,
        response.categoriesDto?.first.strCategoryThumb,
      );
      expect(
        entity.categoriesDtoEntity.first.strCategoryDescription,
        response.categoriesDto?.first.strCategoryDescription,
      );
    });

    test("MusclesDtoMapper", () {
      // Arrange
      final dto = MusclesDto(id: 'id', name: 'name', image: 'image');

      // Act
      final entity = dto.toEntity();

      // Assert
      expect(entity, isA<MusclesDtoEntity>());
      expect(entity.id, dto.id);
      expect(entity.name, dto.name);
      expect(entity.image, dto.image);
    });

    test("MusclesRandomResponseMapper", () {
      // Arrange
      final response = MusclesRandomResponse(
        message: "Success",
        totalMuscles: 3,
        musclesDto: [MusclesDto(id: "id", name: "name", image: "image")],
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity, isA<MusclesRandomEntity>());
      expect(entity.message, response.message);
      expect(entity.totalMuscles, response.totalMuscles);
      expect(entity.musclesDtoEntity, isNotEmpty);
      expect(entity.musclesDtoEntity.first.id, response.musclesDto?.first.id);
      expect(
        entity.musclesDtoEntity.first.name,
        response.musclesDto?.first.name,
      );
      expect(
        entity.musclesDtoEntity.first.image,
        response.musclesDto?.first.image,
      );
    });

    test("GetAllMusclesResponseMapper", () {
      // Arrange
      final response = GetAllMusclesResponse(
        message: "success",
        musclesGroupDto: [MusclesGroupDto(id: "id", name: "name")],
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity, isA<GetAllMusclesEntity>());
      expect(entity.message, response.message);
      expect(entity.musclesGroupDtoEntity, isNotEmpty);
      expect(
        entity.musclesGroupDtoEntity.first.id,
        response.musclesGroupDto?.first.id,
      );
      expect(
        entity.musclesGroupDtoEntity.first.name,
        response.musclesGroupDto?.first.name,
      );
    });

    test("MuscleGroupDtoMapper", () {
      // Arrange
      final dto = MuscleGroupDto(id: "id", name: "name");

      // Act
      final entity = dto.toEntity();

      // Assert
      expect(entity, isA<MuscleGroupDtoEntity>());
      expect(entity.id, dto.id);
      expect(entity.name, dto.name);
    });

    test("MusclesGroupDtoMapper", () {
      // Arrange
      final dto = MusclesGroupDto(id: "id", name: "name");

      // Act
      final entity = dto.toEntity();

      // Assert
      expect(entity, isA<MusclesGroupDtoEntity>());
      expect(entity.id, dto.id);
      expect(entity.name, dto.name);
    });

    test("MusclesGroupIdResponseMapper", () {
      // Arrange
      final response = MusclesGroupIdResponse(
        message: "success",
        muscleGroupDto: MuscleGroupDto(id: "id", name: "name"),
        musclesDto: [MusclesDto(id: "id1", name: "name1", image: "image1")],
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity, isA<MusclesGroupIdEntity>());
      expect(entity.message, response.message);
      expect(entity.muscleGroupDtoEntity.id, response.muscleGroupDto?.id);
      expect(entity.muscleGroupDtoEntity.name, response.muscleGroupDto?.name);
      expect(entity.musclesDtoEntity, isNotEmpty);
      expect(entity.musclesDtoEntity.first.id, response.musclesDto?.first.id);
      expect(
        entity.musclesDtoEntity.first.name,
        response.musclesDto?.first.name,
      );
      expect(
        entity.musclesDtoEntity.first.image,
        response.musclesDto?.first.image,
      );
    });
  });
}
