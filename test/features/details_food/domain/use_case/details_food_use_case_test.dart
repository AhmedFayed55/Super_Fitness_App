import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:super_fitness_app/features/details_food/domain/repositories/details_food_repo.dart';
import 'package:super_fitness_app/features/details_food/domain/use_case/details_food_use_case.dart';
import 'details_food_use_case_test.mocks.dart';

@GenerateMocks([DetailsFoodRepo])
void main() {
  late MockDetailsFoodRepo mockDetailsFoodRepo;
  late DetailsFoodUseCase detailsFoodUseCase;
  late DetailsFoodEntity detailsFoodEntity;
  setUpAll(() {
    detailsFoodEntity = DetailsFoodEntity(
      id: 'id',
      name: 'name',
      category: 'category',
      area: 'area',
      instructions: 'instructions',
      imageUrl: 'imageUrl',
      tags: 'tags',
      youtubeUrl: 'youtubeUrl',
      ingredients: [],
      sourceUrl: 'sourceUrl',
    );
    mockDetailsFoodRepo = MockDetailsFoodRepo();
    detailsFoodUseCase = DetailsFoodUseCase(mockDetailsFoodRepo);
  });
  group('test detailsFoodUseCase', () {
    test('test use case Details food on success', () async {
      provideDummy<ApiResult<DetailsFoodEntity>>(
        ApiSuccessResult(data: detailsFoodEntity),
      );
      when(
        mockDetailsFoodRepo.detailsFoodRepo(''),
      ).thenAnswer((_) async => ApiSuccessResult(data: detailsFoodEntity));
      var result = await detailsFoodUseCase.call('');
      verify(mockDetailsFoodRepo.detailsFoodRepo('')).called(1);
      expect(result, isA<ApiSuccessResult<DetailsFoodEntity>>());
    });
    test('test use case Details food on error', () async {
      provideDummy<ApiResult<DetailsFoodEntity>>(
        ApiErrorResult(failure: Failure(errorMessage: 'error')),
      );
      when(mockDetailsFoodRepo.detailsFoodRepo('')).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'error')),
      );
      var result = await detailsFoodUseCase.call('');
      verify(mockDetailsFoodRepo.detailsFoodRepo('')).called(1);
      expect(result, isA<ApiErrorResult<DetailsFoodEntity>>());
    });
  });
}
