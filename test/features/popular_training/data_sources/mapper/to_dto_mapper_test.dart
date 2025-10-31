import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';

void main() {
  group('PopularTrainingRequestMapper Tests', () {
    test(
      'GetAllExercisesRequestEntity → GetAllExercisesRequestDto mapping should be correct',
      () {
        const mockEntity = GetAllExercisesRequestEntity(page: 2, limit: 15);

        final result = mockEntity.toDto();

        expect(result, isA<GetAllExercisesRequestDto>());
        expect(result.page, equals(mockEntity.page));
        expect(result.limit, equals(mockEntity.limit));
      },
    );
  });
}
