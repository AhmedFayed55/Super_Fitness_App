import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/home_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:super_fitness_app/features/home_screen/data/repositories_impl/home_repo_impl.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeDataSource])
void main() {
  late HomeDataSource mockDataSource;
  late HomeRepoImpl homeRepoImpl;

  late GetAllMusclesResponse getAllMusclesResponse;
  late MusclesGroupIdResponse musclesGroupIdResponse;
  late MealsCategoriesResponse mealsCategoriesResponse;
  late MusclesRandomResponse musclesRandomResponse;

  setUp(() {
    mockDataSource = MockHomeDataSource();
    homeRepoImpl = HomeRepoImpl(mockDataSource);

    getAllMusclesResponse = GetAllMusclesResponse(
      message: "Success",
      musclesGroupDto: [MusclesGroupDto(id: "1", name: "Arms")],
    );

    musclesGroupIdResponse = MusclesGroupIdResponse(
      message: "Success",
      muscleGroupDto: MuscleGroupDto(id: "1", name: "Chest"),
      musclesDto: [MusclesDto(id: "10", name: "Push Up", image: "img.png")],
    );

    mealsCategoriesResponse = MealsCategoriesResponse(
      categoriesDto: [
        CategoriesDto(
          idCategory: "1",
          strCategory: "Beef",
          strCategoryThumb: "thumb.png",
          strCategoryDescription: "desc",
        ),
      ],
    );

    musclesRandomResponse = MusclesRandomResponse(
      message: "Success",
      totalMuscles: 1,
      musclesDto: [MusclesDto(id: "20", name: "Leg Day", image: "leg.png")],
    );
  });

  group('Test HomeRepoImpl', () {
    group('getAllMuscles', () {
      test('should return ApiSuccessResult when successful', () async {
        when(
          mockDataSource.getAllMuscles(),
        ).thenAnswer((_) async => getAllMusclesResponse);

        final result = await homeRepoImpl.getAllMuscles();

        verify(mockDataSource.getAllMuscles()).called(1);

        expect(result, isA<ApiSuccessResult<GetAllMusclesEntity>>());
        final success = result as ApiSuccessResult<GetAllMusclesEntity>;
        expect(success.data.musclesGroupDtoEntity.first.name, "Arms");
      });

      test('should return ApiErrorResult on DioException', () async {
        when(
          mockDataSource.getAllMuscles(),
        ).thenThrow(DioException(requestOptions: RequestOptions()));

        final result = await homeRepoImpl.getAllMuscles();

        expect(result, isA<ApiErrorResult<GetAllMusclesEntity>>());
        final error = result as ApiErrorResult<GetAllMusclesEntity>;
        expect(error.failure, isA<ServerFailure>());
      });

      test('should return ApiErrorResult on generic Exception', () async {
        when(mockDataSource.getAllMuscles()).thenThrow(Exception('Error'));

        final result = await homeRepoImpl.getAllMuscles();

        expect(result, isA<ApiErrorResult<GetAllMusclesEntity>>());
        final error = result as ApiErrorResult<GetAllMusclesEntity>;
        expect(error.failure, isA<Failure>());
      });
    });

    group('getMusclesGroupId', () {
      test('should return ApiSuccessResult when successful', () async {
        const id = "1";
        when(
          mockDataSource.getMusclesGroupId(id),
        ).thenAnswer((_) async => musclesGroupIdResponse);

        final result = await homeRepoImpl.getMusclesGroupId(id);

        verify(mockDataSource.getMusclesGroupId(id)).called(1);

        expect(result, isA<ApiSuccessResult<MusclesGroupIdEntity>>());
        final success = result as ApiSuccessResult<MusclesGroupIdEntity>;
        expect(success.data.muscleGroupDtoEntity.name, "Chest");
      });

      test('should return ApiErrorResult on DioException', () async {
        const id = "1";
        when(
          mockDataSource.getMusclesGroupId(id),
        ).thenThrow(DioException(requestOptions: RequestOptions()));

        final result = await homeRepoImpl.getMusclesGroupId(id);

        expect(result, isA<ApiErrorResult<MusclesGroupIdEntity>>());
        final error = result as ApiErrorResult<MusclesGroupIdEntity>;
        expect(error.failure, isA<ServerFailure>());
      });

      test('should return ApiErrorResult on generic Exception', () async {
        const id = "1";
        when(
          mockDataSource.getMusclesGroupId(id),
        ).thenThrow(Exception('Error'));

        final result = await homeRepoImpl.getMusclesGroupId(id);

        expect(result, isA<ApiErrorResult<MusclesGroupIdEntity>>());
        final error = result as ApiErrorResult<MusclesGroupIdEntity>;
        expect(error.failure, isA<Failure>());
      });
    });

    group('recommendationForYou', () {
      test('should return ApiSuccessResult when successful', () async {
        when(
          mockDataSource.recommendationForYou(),
        ).thenAnswer((_) async => mealsCategoriesResponse);

        final result = await homeRepoImpl.recommendationForYou();

        verify(mockDataSource.recommendationForYou()).called(1);

        expect(result, isA<ApiSuccessResult<MealsCategoriesEntity>>());
        final success = result as ApiSuccessResult<MealsCategoriesEntity>;
        expect(success.data.categoriesDtoEntity.first.strCategory, "Beef");
      });

      test('should return ApiErrorResult on DioException', () async {
        when(
          mockDataSource.recommendationForYou(),
        ).thenThrow(DioException(requestOptions: RequestOptions()));

        final result = await homeRepoImpl.recommendationForYou();

        expect(result, isA<ApiErrorResult<MealsCategoriesEntity>>());
        final error = result as ApiErrorResult<MealsCategoriesEntity>;
        expect(error.failure, isA<ServerFailure>());
      });

      test('should return ApiErrorResult on generic Exception', () async {
        when(
          mockDataSource.recommendationForYou(),
        ).thenThrow(Exception('Error'));

        final result = await homeRepoImpl.recommendationForYou();

        expect(result, isA<ApiErrorResult<MealsCategoriesEntity>>());
        final error = result as ApiErrorResult<MealsCategoriesEntity>;
        expect(error.failure, isA<Failure>());
      });
    });

    group('recommendationToDay', () {
      test('should return ApiSuccessResult when successful', () async {
        when(
          mockDataSource.recommendationToDay(),
        ).thenAnswer((_) async => musclesRandomResponse);

        final result = await homeRepoImpl.recommendationToDay();

        verify(mockDataSource.recommendationToDay()).called(1);

        expect(result, isA<ApiSuccessResult<MusclesRandomEntity>>());
        final success = result as ApiSuccessResult<MusclesRandomEntity>;
        expect(success.data.musclesDtoEntity.first.name, "Leg Day");
      });

      test('should return ApiErrorResult on DioException', () async {
        when(
          mockDataSource.recommendationToDay(),
        ).thenThrow(DioException(requestOptions: RequestOptions()));

        final result = await homeRepoImpl.recommendationToDay();

        expect(result, isA<ApiErrorResult<MusclesRandomEntity>>());
        final error = result as ApiErrorResult<MusclesRandomEntity>;
        expect(error.failure, isA<ServerFailure>());
      });

      test('should return ApiErrorResult on generic Exception', () async {
        when(
          mockDataSource.recommendationToDay(),
        ).thenThrow(Exception('Error'));

        final result = await homeRepoImpl.recommendationToDay();

        expect(result, isA<ApiErrorResult<MusclesRandomEntity>>());
        final error = result as ApiErrorResult<MusclesRandomEntity>;
        expect(error.failure, isA<Failure>());
      });
    });
  });
}
