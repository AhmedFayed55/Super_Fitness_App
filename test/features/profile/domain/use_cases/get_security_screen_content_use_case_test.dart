import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_security_screen_content_use_case.dart';

import 'get_help_screen_content_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late ProfileRepo mockRepo;
  late SecurityScreenContentUseCase useCase;

  setUp(() {
    mockRepo = MockProfileRepo();
    useCase = SecurityScreenContentUseCase(mockRepo);

    provideDummy<ApiResult<List<SecurityRolesConfigEntity>>>(
      ApiSuccessResult(data: []),
    );
  });

  test('should return ApiSuccessResult with security roles content', () async {
    final mockSecurity = [
      SecurityRolesConfigEntity(title: "Security Title", permissions: []),
    ];
    when(
      mockRepo.getSecurityRolesConfigScreenContent(),
    ).thenAnswer((_) async => ApiSuccessResult(data: mockSecurity));

    final result = await useCase.call();

    verify(mockRepo.getSecurityRolesConfigScreenContent()).called(1);
    expect(result, isA<ApiSuccessResult<List<SecurityRolesConfigEntity>>>());
    final data = (result as ApiSuccessResult).data;
    expect(data.first.title, equals(mockSecurity.first.title));
  });

  test('should return ApiErrorResult when repo fails', () async {
    when(mockRepo.getSecurityRolesConfigScreenContent()).thenAnswer(
      (_) async => ApiErrorResult(failure: Failure(errorMessage: "error")),
    );

    final result = await useCase.call();

    expect(result, isA<ApiErrorResult<List<SecurityRolesConfigEntity>>>());
    final error = result as ApiErrorResult;
    expect(error.failure.errorMessage, "error");
  });
}
