import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_help_screen_content_use_case.dart';
import 'get_help_screen_content_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late ProfileRepo mockRepo;
  late HelpScreenContentUseCase useCase;

  setUp(() {
    mockRepo = MockProfileRepo();
    useCase = HelpScreenContentUseCase(mockRepo);

    provideDummy<ApiResult<List<HelpScreenResponseEntity>>>(
      ApiSuccessResult(data: []),
    );
  });

  test('should return ApiSuccessResult with help content', () async {
    final mockHelp = [
      HelpScreenResponseEntity(title: 'Help Title', content: 'Help Content'),
    ];
    when(
      mockRepo.getHelpScreenContent(),
    ).thenAnswer((_) async => ApiSuccessResult(data: mockHelp));

    final result = await useCase.call();

    verify(mockRepo.getHelpScreenContent()).called(1);
    expect(result, isA<ApiSuccessResult<List<HelpScreenResponseEntity>>>());
    final data = (result as ApiSuccessResult).data;
    expect(data.first.title, mockHelp.first.title);
  });

  test('should return ApiErrorResult when repo fails', () async {
    when(mockRepo.getHelpScreenContent()).thenAnswer(
      (_) async => ApiErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call();

    expect(result, isA<ApiErrorResult<List<HelpScreenResponseEntity>>>());
    final error = result as ApiErrorResult;
    expect(error.failure.errorMessage, "error");
  });
}
