import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/upcoming_workouts/muscles_group_id_response_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/muscles_group_id_response_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'muscles_group_id_response_usecase_test.mocks.dart';

@GenerateMocks([MusclesGroupIdResponseRepo])
void main() {
  late MockMusclesGroupIdResponseRepo mockMusclesGroupIdResponseRepo;
  late MusclesGroupIdResponseUseCase musclesGroupIdResponseUseCase;
  late MusclesGroupIdEntity musclesGroupIdEntity;

  setUp(() {
    musclesGroupIdEntity = MusclesGroupIdEntity(
      message: "Success",
      muscleGroupDtoEntity: MuscleGroupDtoEntity(id: "id", name: "name"),
      musclesDtoEntity: [
        MusclesDtoEntity(id: "id", name: "name", image: "image"),
      ],
    );

    mockMusclesGroupIdResponseRepo = MockMusclesGroupIdResponseRepo();
    musclesGroupIdResponseUseCase = MusclesGroupIdResponseUseCase(
      musclesGroupIdResponseRepo: mockMusclesGroupIdResponseRepo,
    );
  });

  test("success case for MusclesGroupIdResponseUseCase", () async {
    // Arrange
    const muscleGroupId = "test";
    var mockResult = ApiSuccessResult<MusclesGroupIdEntity>(
      data: musclesGroupIdEntity,
    );
    provideDummy<ApiResult<MusclesGroupIdEntity>>(mockResult);

    when(
      mockMusclesGroupIdResponseRepo.getMusclesGroupId(muscleGroupId),
    ).thenAnswer((_) async => mockResult);

    // Act
    var result = await musclesGroupIdResponseUseCase.call(muscleGroupId);

    // Assert
    expect(result, isA<ApiSuccessResult<MusclesGroupIdEntity>>());
    var successResult = result as ApiSuccessResult<MusclesGroupIdEntity>;
    expect(successResult.data.message, equals(musclesGroupIdEntity.message));
    expect(successResult.data.musclesDtoEntity, isNotEmpty);
    expect(
      successResult.data.muscleGroupDtoEntity.name,
      equals(musclesGroupIdEntity.muscleGroupDtoEntity.name),
    );

    verify(
      mockMusclesGroupIdResponseRepo.getMusclesGroupId(muscleGroupId),
    ).called(1);
  });
}
