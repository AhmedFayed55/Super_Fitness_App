import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/get_all_muscles_response_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../recommendation_for_you/recommendation_for_you_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo repo;
  late GetAllMusclesResponseUseCase useCase;
  late GetAllMusclesEntity getAllMusclesEntity;

  setUp(() {
    getAllMusclesEntity = GetAllMusclesEntity(
      message: "message",
      musclesGroupDtoEntity: [MusclesGroupDtoEntity(id: "id", name: "name")],
    );

    repo = MockHomeRepo();
    useCase = GetAllMusclesResponseUseCase(repo);
  });

  test("success case for GetAllMusclesResponseUseCase", () async {
    var mockResult = ApiSuccessResult<GetAllMusclesEntity>(
      data: getAllMusclesEntity,
    );
    provideDummy<ApiResult<GetAllMusclesEntity>>(mockResult);

    when(repo.getAllMuscles()).thenAnswer((_) async => mockResult);

    var result = await useCase.call();

    verify(repo.getAllMuscles()).called(1);

    expect(result, isA<ApiSuccessResult<GetAllMusclesEntity>>());
    var successResult = result as ApiSuccessResult<GetAllMusclesEntity>;
    expect(successResult.data.musclesGroupDtoEntity, isNotEmpty);
    expect(
      successResult.data.musclesGroupDtoEntity.first.name,
      equals(getAllMusclesEntity.musclesGroupDtoEntity.first.name),
    );
  });
}
