import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/data/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';

void main() {
  group("Test convert from entity to Dto", () {
    test("CategoriesDtoEntityMapper", () {
      // Arrange
      final entity = CategoriesEntity(
        idCategory: 'idCategory',
        strCategory: 'strCategory',
        strCategoryThumb: 'strCategoryThumb',
        strCategoryDescription: 'strCategoryDescription',
      );

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<CategoriesDto>());
      expect(dto.idCategory, entity.idCategory);
      expect(dto.strCategory, entity.strCategory);
      expect(dto.strCategoryThumb, entity.strCategoryThumb);
      expect(dto.strCategoryDescription, entity.strCategoryDescription);
    });

    test("MealsCategoriesEntityMapper", () {
      // Arrange
      final entity = MealsCategoriesEntity(
        categoriesDtoEntity: [
          CategoriesEntity(
            idCategory: 'idCategory',
            strCategory: 'strCategory',
            strCategoryThumb: 'strCategoryThumb',
            strCategoryDescription: 'strCategoryDescription',
          ),
        ],
      );

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<MealsCategoriesResponse>());
      expect(dto.categoriesDto, isNotEmpty);
      expect(
        dto.categoriesDto?.first.idCategory,
        entity.categoriesDtoEntity.first.idCategory,
      );
      expect(
        dto.categoriesDto?.first.strCategory,
        entity.categoriesDtoEntity.first.strCategory,
      );
      expect(
        dto.categoriesDto?.first.strCategoryThumb,
        entity.categoriesDtoEntity.first.strCategoryThumb,
      );
      expect(
        dto.categoriesDto?.first.strCategoryDescription,
        entity.categoriesDtoEntity.first.strCategoryDescription,
      );
    });

    test("MusclesDtoEntityMapper", () {
      // Arrange
      final entity = MusclesDtoEntity(id: 'id', name: 'name', image: 'image');

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<MusclesDto>());
      expect(dto.id, entity.id);
      expect(dto.name, entity.name);
      expect(dto.image, entity.image);
    });

    test("MusclesRandomEntityMapper", () {
      // Arrange
      final entity = MusclesRandomEntity(
        message: "message",
        totalMuscles: 2,
        musclesDtoEntity: [
          MusclesDtoEntity(id: "id1", name: "name1", image: "image1"),
          MusclesDtoEntity(id: "id2", name: "name2", image: "image2"),
        ],
      );

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<MusclesRandomResponse>());
      expect(dto.message, entity.message);
      expect(dto.totalMuscles, entity.totalMuscles);
      expect(dto.musclesDto, isNotEmpty);
      expect(dto.musclesDto?.first.id, entity.musclesDtoEntity.first.id);
      expect(dto.musclesDto?.first.name, entity.musclesDtoEntity.first.name);
      expect(dto.musclesDto?.first.image, entity.musclesDtoEntity.first.image);
    });

    test("GetAllMusclesEntityMapper", () {
      // Arrange
      final entity = GetAllMusclesEntity(
        message: "message",
        musclesGroupDtoEntity: [
          MusclesGroupDtoEntity(id: "id1", name: "name1"),
          MusclesGroupDtoEntity(id: "id2", name: "name2"),
        ],
      );

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<GetAllMusclesResponse>());
      expect(dto.message, entity.message);
      expect(dto.musclesGroupDto, isNotEmpty);
      expect(
        dto.musclesGroupDto?.first.id,
        entity.musclesGroupDtoEntity.first.id,
      );
      expect(
        dto.musclesGroupDto?.first.name,
        entity.musclesGroupDtoEntity.first.name,
      );
    });

    test("MuscleGroupDtoEntityMapper", () {
      // Arrange
      final entity = MuscleGroupDtoEntity(id: "id", name: "name");

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<MuscleGroupDto>());
      expect(dto.id, entity.id);
      expect(dto.name, entity.name);
    });

    test("MusclesGroupDtoEntityMapper", () {
      // Arrange
      final entity = MusclesGroupDtoEntity(id: "id", name: "name");

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<MusclesGroupDto>());
      expect(dto.id, entity.id);
      expect(dto.name, entity.name);
    });

    test("MusclesGroupIdEntityMapper", () {
      // Arrange
      final entity = MusclesGroupIdEntity(
        message: "message",
        muscleGroupDtoEntity: MuscleGroupDtoEntity(id: "id", name: "name"),
        musclesDtoEntity: [
          MusclesDtoEntity(id: "id1", name: "name1", image: "image1"),
          MusclesDtoEntity(id: "id2", name: "name2", image: "image2"),
        ],
      );

      // Act
      final dto = entity.toDto();

      // Assert
      expect(dto, isA<MusclesGroupIdResponse>());
      expect(dto.message, entity.message);
      expect(dto.muscleGroupDto?.id, entity.muscleGroupDtoEntity.id);
      expect(dto.muscleGroupDto?.name, entity.muscleGroupDtoEntity.name);
      expect(dto.musclesDto, isNotEmpty);
      expect(dto.musclesDto?.first.id, entity.musclesDtoEntity.first.id);
      expect(dto.musclesDto?.first.name, entity.musclesDtoEntity.first.name);
      expect(dto.musclesDto?.first.image, entity.musclesDtoEntity.first.image);
    });
  });
}
