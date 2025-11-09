import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/home_ds_impl.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/categories_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscle_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_dto.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:test/test.dart';

import 'home_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices, MealsApiServices])
void main() {
  late ApiServices mockApiServices;
  late MealsApiServices mockMealsApiServices;
  late HomeDataSourceImpl homeDataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    mockMealsApiServices = MockMealsApiServices();
    homeDataSource = HomeDataSourceImpl(mockApiServices, mockMealsApiServices);
  });

  group('HomeDataSourceImpl Tests', () {
    test('getAllMuscles returns GetAllMusclesResponse correctly', () async {
      final mockResponse = GetAllMusclesResponse(
        message: "message",
        musclesGroupDto: [MusclesGroupDto(id: "1", name: "1")],
      );
      when(
        mockApiServices.upcomingWorkoutsTab(),
      ).thenAnswer((_) async => mockResponse);

      final result = await homeDataSource.getAllMuscles();

      expect(result, isA<GetAllMusclesResponse>());
      expect(result.musclesGroupDto, isNotEmpty);
      expect(result.message, equals(mockResponse.message));
      verify(mockApiServices.upcomingWorkoutsTab()).called(1);
    });

    test(
      'getMusclesGroupId returns MusclesGroupIdResponse correctly',
      () async {
        const testMuscleGroupId = "test";
        final mockResponse = MusclesGroupIdResponse(
          message: "message",
          muscleGroupDto: MuscleGroupDto(id: "1", name: "1"),
          musclesDto: [MusclesDto(id: "11", name: "11", image: "11")],
        );
        when(
          mockApiServices.upcomingWorkoutsTabItems(testMuscleGroupId),
        ).thenAnswer((_) async => mockResponse);

        final result = await homeDataSource.getMusclesGroupId(
          testMuscleGroupId,
        );

        verify(
          mockApiServices.upcomingWorkoutsTabItems(testMuscleGroupId),
        ).called(1);

        expect(result, isA<MusclesGroupIdResponse>());
        expect(result.musclesDto, isNotEmpty);
        expect(result.muscleGroupDto, isNotNull);
        expect(
          result.muscleGroupDto?.id,
          equals(mockResponse.muscleGroupDto?.id),
        );
        expect(
          result.musclesDto?.first.id,
          equals(mockResponse.musclesDto?.first.id),
        );
      },
    );

    test(
      'recommendationForYou returns MealsCategoriesResponse correctly',
      () async {
        final categories = [
          CategoriesDto(
            idCategory: "idCategory",
            strCategory: "strCategory",
            strCategoryThumb: "thumb",
            strCategoryDescription: "desc",
          ),
        ];
        final mockResponse = MealsCategoriesResponse(categoriesDto: categories);

        when(
          mockMealsApiServices.recommendationForYou(),
        ).thenAnswer((_) async => mockResponse);

        final result = await homeDataSource.recommendationForYou();

        verify(mockMealsApiServices.recommendationForYou()).called(1);

        expect(result, isA<MealsCategoriesResponse>());
        expect(result.categoriesDto, isNotEmpty);
        expect(
          result.categoriesDto?.first.idCategory,
          equals(categories.first.idCategory),
        );
        expect(
          result.categoriesDto?.first.strCategory,
          equals(categories.first.strCategory),
        );
      },
    );

    test(
      'recommendationToDay returns MusclesRandomResponse correctly',
      () async {
        final mockResponse = MusclesRandomResponse(
          message: "message",
          totalMuscles: 1,
          musclesDto: [MusclesDto(id: "1", name: "1", image: "1")],
        );
        when(
          mockApiServices.recommendationToDay(),
        ).thenAnswer((_) async => mockResponse);

        final result = await homeDataSource.recommendationToDay();

        verify(mockApiServices.recommendationToDay()).called(1);

        expect(result, isA<MusclesRandomResponse>());
        expect(result.musclesDto, isNotEmpty);
        expect(result.totalMuscles, equals(mockResponse.totalMuscles));
        expect(result.message, equals(mockResponse.message));
      },
    );
  });
}
