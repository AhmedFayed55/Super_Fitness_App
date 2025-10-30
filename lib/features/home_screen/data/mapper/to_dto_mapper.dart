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

extension CategoriesDtoEntityMapper on CategoriesDtoEntity {
  CategoriesDto toDto() {
    return CategoriesDto(
      idCategory: idCategory,
      strCategory: strCategory,
      strCategoryThumb: strCategoryThumb,
      strCategoryDescription: strCategoryDescription,
    );
  }
}

extension MealsCategoriesEntityMapper on MealsCategoriesEntity {
  MealsCategoriesResponse toDto() {
    return MealsCategoriesResponse(
      categoriesDto: categoriesDtoEntity.map((e) => e.toDto()).toList(),
    );
  }
}

extension MusclesDtoEntityMapper on MusclesDtoEntity {
  MusclesDto toDto() {
    return MusclesDto(image: image, name: name, id: id);
  }
}

extension MusclesRandomEntityMapper on MusclesRandomEntity {
  MusclesRandomResponse toDto() {
    return MusclesRandomResponse(
      message: message,
      totalMuscles: totalMuscles,
      musclesDto: musclesDtoEntity.map((e) => e.toDto()).toList(),
    );
  }
}

extension GetAllMusclesEntityMapper on GetAllMusclesEntity {
  GetAllMusclesResponse toDto() {
    return GetAllMusclesResponse(
      message: message,
      musclesGroupDto: musclesGroupDtoEntity.map((e) => e.toDto()).toList(),
    );
  }
}

extension MuscleGroupDtoEntityMapper on MuscleGroupDtoEntity {
  MuscleGroupDto toDto() {
    return MuscleGroupDto(id: id, name: name);
  }
}

extension MusclesGroupDtoEntityMapper on MusclesGroupDtoEntity {
  MusclesGroupDto toDto() {
    return MusclesGroupDto(id: id, name: name);
  }
}

extension MusclesGroupIdEntityMapper on MusclesGroupIdEntity {
  MusclesGroupIdResponse toDto() {
    return MusclesGroupIdResponse(
      message: message,
      muscleGroupDto: muscleGroupDtoEntity.toDto(),
      musclesDto: musclesDtoEntity.map((e) => e.toDto()).toList(),
    );
  }
}
