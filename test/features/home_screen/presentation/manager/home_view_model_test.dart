import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/get_profile_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/recommendation_for_you/recommendation_for_you_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/recommendation_to_day/recommendation_to_day_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/get_all_muscles_response_usecase.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/muscles_group_id_response_usecase.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_event.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'home_view_model_test.mocks.dart';

@GenerateMocks([
  RecommendationToDayUseCase,
  RecommendationForYouUseCase,
  GetAllMusclesResponseUseCase,
  MusclesGroupIdResponseUseCase,
  GetUserProfileUseCase,
])
void main() {
  late MockRecommendationToDayUseCase mockRecToDayUseCase;
  late MockRecommendationForYouUseCase mockRecForYouUseCase;
  late MockGetAllMusclesResponseUseCase mockUpcomingTabUseCase;
  late MockMusclesGroupIdResponseUseCase mockUpcomingTabItemsUseCase;
  late MockGetUserProfileUseCase mockGetUserProfileUseCase;
  late HomeCubit homeCubit;

  setUp(() {
    mockRecToDayUseCase = MockRecommendationToDayUseCase();
    mockRecForYouUseCase = MockRecommendationForYouUseCase();
    mockUpcomingTabUseCase = MockGetAllMusclesResponseUseCase();
    mockUpcomingTabItemsUseCase = MockMusclesGroupIdResponseUseCase();
    mockGetUserProfileUseCase = MockGetUserProfileUseCase();

    homeCubit = HomeCubit(
      mockRecToDayUseCase,
      mockRecForYouUseCase,
      mockUpcomingTabUseCase,
      mockUpcomingTabItemsUseCase,
      mockGetUserProfileUseCase,
    );
  });

  group("HomeCubit - RecommendationToDay", () {
    test('Success case', () async {
      var data = MusclesRandomEntity(
        message: 'message',
        totalMuscles: 1,
        musclesDtoEntity: [
          MusclesDtoEntity(id: "1", name: "name 1", image: "image 1"),
          MusclesDtoEntity(id: "2", name: "name 2", image: "image 2"),
        ],
      );

      provideDummy<ApiResult<MusclesRandomEntity>>(
        ApiSuccessResult(data: data),
      );

      when(mockRecToDayUseCase.call()).thenAnswer(
        (_) async => ApiSuccessResult<MusclesRandomEntity>(data: data),
      );

      await homeCubit.doIntent(RecommendationToDayEvent());

      expect(homeCubit.state.today, ScreenStatus.isSuccess);
      expect(homeCubit.state.todayData, data);
    });

    test('Error case', () async {
      provideDummy<ApiResult<MealsCategoriesEntity>>(
        ApiSuccessResult(
          data: MealsCategoriesEntity(
            categoriesDtoEntity: [
              CategoriesEntity(
                idCategory: "1",
                strCategory: "strCategory 1",
                strCategoryDescription: "Description 1",
                strCategoryThumb: "image 1",
              ),
              CategoriesEntity(
                idCategory: "2",
                strCategory: "strCategory 2",
                strCategoryDescription: "Description 2",
                strCategoryThumb: "image 2",
              ),
            ],
          ),
        ),
      );

      when(mockRecToDayUseCase.call()).thenAnswer(
        (_) async => ApiErrorResult<MusclesRandomEntity>(
          failure: Failure(errorMessage: "error"),
        ),
      );

      await homeCubit.doIntent(RecommendationToDayEvent());

      expect(homeCubit.state.today, ScreenStatus.isError);
    });
  });

  group('HomeCubit - UpcomingWorkoutsTabItems', () {
    test('Success case', () async {
      var data = MusclesGroupIdEntity(
        message: 'message',
        muscleGroupDtoEntity: MuscleGroupDtoEntity(id: "id", name: "name"),
        musclesDtoEntity: [
          MusclesDtoEntity(id: "1", name: "name 1", image: "image 1"),
          MusclesDtoEntity(id: "2", name: "name 2", image: "image 2"),
        ],
      );

      provideDummy<ApiResult<MusclesGroupIdEntity>>(
        ApiSuccessResult(
          data: MusclesGroupIdEntity(
            message: 'message',
            muscleGroupDtoEntity: MuscleGroupDtoEntity(id: 'id', name: 'name'),
            musclesDtoEntity: [
              MusclesDtoEntity(id: "id 1", name: "name 1", image: "image 1"),
              MusclesDtoEntity(id: "id 2", name: "name 2", image: "image 2"),
            ],
          ),
        ),
      );

      when(mockUpcomingTabItemsUseCase.call(any)).thenAnswer(
        (_) async => ApiSuccessResult<MusclesGroupIdEntity>(data: data),
      );

      await homeCubit.doIntent(
        UpcomingWorkoutsTabItemsEvent(musclesGroupId: '1'),
      );

      expect(homeCubit.state.upcomingTabItems, ScreenStatus.isSuccess);
      expect(homeCubit.state.upcomingTabItemsData, data);
    });

    test('Error case', () async {
      provideDummy<ApiResult<MusclesGroupIdEntity>>(
        ApiSuccessResult(
          data: MusclesGroupIdEntity(
            message: 'message',
            muscleGroupDtoEntity: MuscleGroupDtoEntity(id: 'id', name: 'name'),
            musclesDtoEntity: [
              MusclesDtoEntity(id: 'id 1', name: 'name 1', image: 'image 1'),
              MusclesDtoEntity(id: 'id 2', name: 'name 2', image: 'image 2'),
            ],
          ),
        ),
      );

      when(mockUpcomingTabItemsUseCase.call(any)).thenAnswer(
        (_) async => ApiErrorResult<MusclesGroupIdEntity>(
          failure: Failure(errorMessage: "error"),
        ),
      );

      await homeCubit.doIntent(
        UpcomingWorkoutsTabItemsEvent(musclesGroupId: '1'),
      );

      expect(homeCubit.state.upcomingTabItems, ScreenStatus.isError);
    });
  });

  group("HomeCubit - recommendationForYou", () {
    test("Success case", () async {
      final data = MealsCategoriesEntity(
        categoriesDtoEntity: [
          CategoriesEntity(
            idCategory: "idCategory 1",
            strCategory: "strCategory 1",
            strCategoryThumb: "strCategoryThumb 1",
            strCategoryDescription: "strCategoryDescription 1",
          ),
          CategoriesEntity(
            idCategory: "idCategory 2",
            strCategory: "strCategory 2",
            strCategoryThumb: "strCategoryThumb 2",
            strCategoryDescription: "strCategoryDescription 2",
          ),
        ],
      );
      provideDummy<ApiResult<MealsCategoriesEntity>>(
        ApiSuccessResult(data: data),
      );

      when(
        mockRecForYouUseCase.call(),
      ).thenAnswer((_) async => ApiSuccessResult(data: data));

      await homeCubit.doIntent(RecommendationForYouEvent());

      expect(homeCubit.state.forYou, ScreenStatus.isSuccess);
      expect(homeCubit.state.forYouData, data);
    });

    test("Error case", () async {
      final error = ApiErrorResult<MealsCategoriesEntity>(
        failure: Failure(errorMessage: "error"),
      );
      provideDummy<ApiResult<MealsCategoriesEntity>>(error);

      when(mockRecForYouUseCase.call()).thenAnswer((_) async => error);

      await homeCubit.doIntent(RecommendationForYouEvent());

      expect(homeCubit.state.forYou, ScreenStatus.isError);
    });
  });

  group("HomeCubit - upcomingWorkoutsTab", () {
    test("Success case", () async {
      final data = GetAllMusclesEntity(
        message: "success",
        musclesGroupDtoEntity: [],
      );
      provideDummy<ApiResult<GetAllMusclesEntity>>(
        ApiSuccessResult(data: data),
      );

      when(
        mockUpcomingTabUseCase.call(),
      ).thenAnswer((_) async => ApiSuccessResult(data: data));

      await homeCubit.doIntent(UpcomingWorkoutsTabEvent());

      expect(homeCubit.state.upcomingTab, ScreenStatus.isSuccess);
      expect(homeCubit.state.upcomingTabData, data);
    });

    test("Error case", () async {
      final error = ApiErrorResult<GetAllMusclesEntity>(
        failure: Failure(errorMessage: "error"),
      );
      provideDummy<ApiResult<GetAllMusclesEntity>>(error);

      when(mockUpcomingTabUseCase.call()).thenAnswer((_) async => error);

      await homeCubit.doIntent(UpcomingWorkoutsTabEvent());

      expect(homeCubit.state.upcomingTab, ScreenStatus.isError);
    });
  });

  group("HomeCubit - getUserProfile", () {
    test("Success case", () async {
      final data = UserDataResponseEntity(
        id: "123",
        firstName: "Mohamed",
        lastName: "Ali",
        email: "mohamed@example.com",
        photo: "photo_url",
        activityLevel: "activityLevel",
        age: 1,
        gender: "gender",
        height: 1,
        weight: 1,
        goal: "goal",
        createdAt: "createdAt",
      );
      provideDummy<ApiResult<UserDataResponseEntity>>(
        ApiSuccessResult(data: data),
      );

      when(
        mockGetUserProfileUseCase.call(),
      ).thenAnswer((_) async => ApiSuccessResult(data: data));

      await homeCubit.doIntent(GetUserProfileEvent());

      // Assert
      expect(homeCubit.state.isLoadingImage, false);
      expect(homeCubit.state.isSuccessImage, true);
      expect(homeCubit.state.userData, data);
    });

    test("Error case", () async {
      final error = ApiErrorResult<UserDataResponseEntity>(
        failure: Failure(errorMessage: "error"),
      );

      provideDummy<ApiResult<UserDataResponseEntity>>(error);
      when(mockGetUserProfileUseCase.call()).thenAnswer((_) async => error);

      await homeCubit.doIntent(GetUserProfileEvent());

      // Assert
      expect(homeCubit.state.isLoadingImage, false);
      expect(homeCubit.state.isErrorImage, true);
      expect(homeCubit.state.userData, null);
    });
  });
}
