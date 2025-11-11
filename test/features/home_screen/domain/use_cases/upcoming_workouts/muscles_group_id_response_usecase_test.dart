import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/upcoming_workouts/muscles_group_id_response_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../recommendation_for_you/recommendation_for_you_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo repo;
  late MusclesGroupIdResponseUseCase useCase;
  late MusclesGroupIdEntity musclesGroupIdEntity;

  setUp(() {
    musclesGroupIdEntity = MusclesGroupIdEntity(
      message: "Success",
      muscleGroupDtoEntity: MuscleGroupDtoEntity(id: "id", name: "name"),
      musclesDtoEntity: [
        MusclesDtoEntity(id: "id", name: "name", image: "image"),
      ],
    );

    repo = MockHomeRepo();
    useCase = MusclesGroupIdResponseUseCase(repo);
  });

  test("success case for MusclesGroupIdResponseUseCase", () async {
    const muscleGroupId = "test";
    var mockResult = ApiSuccessResult<MusclesGroupIdEntity>(
      data: musclesGroupIdEntity,
    );
    provideDummy<ApiResult<MusclesGroupIdEntity>>(mockResult);

    when(
      repo.getMusclesGroupId(muscleGroupId),
    ).thenAnswer((_) async => mockResult);

    var result = await useCase.call(muscleGroupId);

    verify(repo.getMusclesGroupId(muscleGroupId)).called(1);

    expect(result, isA<ApiSuccessResult<MusclesGroupIdEntity>>());
    var successResult = result as ApiSuccessResult<MusclesGroupIdEntity>;
    expect(successResult.data.message, equals(musclesGroupIdEntity.message));
    expect(successResult.data.musclesDtoEntity, isNotEmpty);
    expect(
      successResult.data.muscleGroupDtoEntity.name,
      equals(musclesGroupIdEntity.muscleGroupDtoEntity.name),
    );
  });
}
