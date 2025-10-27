import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/upcoming_workouts/get_all_muscles_response_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/get_all_muscles_response_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_muscles_response_usecase_test.mocks.dart';

@GenerateMocks([GetAllMusclesResponseRepo])
void main() {
  late MockGetAllMusclesResponseRepo mockGetAllMusclesResponseRepo;
  late GetAllMusclesResponseUseCase getAllMusclesResponseUseCase;
  late GetAllMusclesEntity getAllMusclesEntity;

  setUp(() {
    getAllMusclesEntity = GetAllMusclesEntity(
      message: "message",
      musclesGroupDtoEntity: [MusclesGroupDtoEntity(id: "id", name: "name")],
    );

    mockGetAllMusclesResponseRepo = MockGetAllMusclesResponseRepo();
    getAllMusclesResponseUseCase = GetAllMusclesResponseUseCase(
      getAllMusclesResponseRepo: mockGetAllMusclesResponseRepo,
    );
  });

  test("success case for GetAllMusclesResponseUseCase", () async {
    // Arrange
    var mockResult = ApiSuccessResult<GetAllMusclesEntity>(
      data: getAllMusclesEntity,
    );
    provideDummy<ApiResult<GetAllMusclesEntity>>(mockResult);

    when(
      mockGetAllMusclesResponseRepo.getAllMuscles(),
    ).thenAnswer((_) async => mockResult);

    // Act
    var result = await getAllMusclesResponseUseCase.call();

    // Assert
    expect(result, isA<ApiSuccessResult<GetAllMusclesEntity>>());
    var successResult = result as ApiSuccessResult<GetAllMusclesEntity>;
    expect(successResult.data.musclesGroupDtoEntity, isNotEmpty);
    expect(
      successResult.data.musclesGroupDtoEntity.first.name,
      equals(getAllMusclesEntity.musclesGroupDtoEntity.first.name),
    );

    verify(mockGetAllMusclesResponseRepo.getAllMuscles()).called(1);
  });
}
