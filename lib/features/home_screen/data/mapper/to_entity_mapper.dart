import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';

extension CategoriesDtoMapper on CategoriesDto {
  CategoriesEntity toEntity() {
    return CategoriesEntity(
      idCategory: idCategory ?? "",
      strCategory: strCategory ?? "",
      strCategoryThumb: strCategoryThumb ?? "",
      strCategoryDescription: strCategoryDescription ?? "",
    );
  }
}

extension MealsCategoriesResponseMapper on MealsCategoriesResponse {
  MealsCategoriesEntity toEntity() {
    return MealsCategoriesEntity(
      categoriesDtoEntity:
          categoriesDto?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension MusclesDtoMapper on MusclesDto {
  MusclesDtoEntity toEntity() {
    return MusclesDtoEntity(name: name ?? "", id: id ?? "", image: image ?? "");
  }
}

extension MusclesRandomResponseMapper on MusclesRandomResponse {
  MusclesRandomEntity toEntity() {
    return MusclesRandomEntity(
      message: message ?? "",
      totalMuscles: totalMuscles ?? 0,
      musclesDtoEntity: musclesDto?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension GetAllMusclesResponseMapper on GetAllMusclesResponse {
  GetAllMusclesEntity toEntity() {
    return GetAllMusclesEntity(
      message: message ?? "",
      musclesGroupDtoEntity:
          musclesGroupDto?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension MuscleGroupDtoMapper on MuscleGroupDto {
  MuscleGroupDtoEntity toEntity() {
    return MuscleGroupDtoEntity(id: id ?? "", name: name ?? "");
  }
}

extension MusclesGroupDtoMapper on MusclesGroupDto {
  MusclesGroupDtoEntity toEntity() {
    return MusclesGroupDtoEntity(id: id ?? "", name: name ?? "");
  }
}

extension MusclesGroupIdResponseMapper on MusclesGroupIdResponse {
  MusclesGroupIdEntity toEntity() {
    return MusclesGroupIdEntity(
      message: message ?? "",
      muscleGroupDtoEntity:
          muscleGroupDto?.toEntity() ?? MuscleGroupDtoEntity(id: "", name: ""),
      musclesDtoEntity: musclesDto?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
