import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/repositories/profile_repo.dart';
import 'package:super_fitness_app/features/auth/profile/domain/use_cases/get_privacy_screen_content_use_case.dart';

import 'get_help_screen_content_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late ProfileRepo mockRepo;
  late GetPrivacyScreenContentUseCase useCase;

  setUp(() {
    mockRepo = MockProfileRepo();
    useCase = GetPrivacyScreenContentUseCase(mockRepo);

    provideDummy<ApiResult<List<PrivacyPolicyEntity>>>(ApiSuccessResult(data: []));
  });

  test('should return ApiSuccessResult with privacy content', () async {
    final mockPrivacy = [
      PrivacyPolicyEntity(title: 'Privacy Title', content: ['Privacy Content'])
    ];
    when(mockRepo.getPrivacyAndSecurityScreenContent())
        .thenAnswer((_) async => ApiSuccessResult(data: mockPrivacy));

    final result = await useCase.call();

    verify(mockRepo.getPrivacyAndSecurityScreenContent()).called(1);
    expect(result, isA<ApiSuccessResult<List<PrivacyPolicyEntity>>>());
    final data = (result as ApiSuccessResult).data;
    expect(data.first.title, equals(mockPrivacy.first.title));
  });

  test('should return ApiErrorResult when repo fails', () async {
    when(mockRepo.getPrivacyAndSecurityScreenContent())
        .thenAnswer((_) async => ApiErrorResult(failure: Failure(errorMessage: 'error')));

    final result = await useCase.call();

    expect(result, isA<ApiErrorResult<List<PrivacyPolicyEntity>>>());
    final error = result as ApiErrorResult;
    expect(error.failure.errorMessage, "error");
  });
}
