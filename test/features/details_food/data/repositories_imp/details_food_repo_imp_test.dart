import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/details_food/data/data_source/details_food_ds.dart';
import 'package:super_fitness_app/features/details_food/data/models/response/details_food_response_dto.dart';
import 'package:super_fitness_app/features/details_food/data/repositories_imp/details_food_repo_imp.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';

import 'details_food_repo_imp_test.mocks.dart';

@GenerateMocks([DetailsFoodDataSource])
void main() {
  late MockDetailsFoodDataSource mockDetailsFoodDataSource;
  late DetailsFoodResponseDto detailsFoodResponseDto;
  late DetailsFoodRepoImp detailsFoodRepoImp;
  setUpAll(() {
    detailsFoodResponseDto = DetailsFoodResponseDto(meals: []);
    mockDetailsFoodDataSource = MockDetailsFoodDataSource();
    detailsFoodRepoImp = DetailsFoodRepoImp(mockDetailsFoodDataSource);
  });

  group('test details food repo', () {
    test(
      'verify when call details food repo is should call details food repo from data source on success',
      () async {
        when(
          mockDetailsFoodDataSource.detailsFoodByIdDataSource(''),
        ).thenAnswer((_) async => detailsFoodResponseDto);
        var result = await detailsFoodRepoImp.detailsFoodRepo('');
        verify(
          mockDetailsFoodDataSource.detailsFoodByIdDataSource(''),
        ).called(1);
        expect(result, isA<ApiResult<DetailsFoodEntity>>());
      },
    );
    test(
      'verify when call details food repo is should call details food repo from data source on success',
      () async {
        when(
          mockDetailsFoodDataSource.detailsFoodByIdDataSource(''),
        ).thenThrow('error');
        var result = await detailsFoodRepoImp.detailsFoodRepo('');
        verify(
          mockDetailsFoodDataSource.detailsFoodByIdDataSource(''),
        ).called(1);
        expect(result, isA<ApiErrorResult<DetailsFoodEntity>>());
      },
    );
  });
}
