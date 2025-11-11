import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/features/auth/logout/domain/use_case/logout_use_case.dart';
import 'package:super_fitness_app/features/auth/logout/presentation/manager/logout_event.dart';
import 'package:super_fitness_app/features/auth/logout/presentation/manager/logout_view_model.dart';

import 'logout_view_model_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  late MockLogoutUseCase useCase;
  late LogoutViewModel viewModel;

  setUp(() {
    useCase = MockLogoutUseCase();
    viewModel = LogoutViewModel(useCase);

    // هنا بنعرف dummy value لنوع ApiResult<LogoutEntity>
    provideDummy<ApiResult<LogoutEntity>>(
      ApiSuccessResult(data: LogoutEntity(message: '')),
    );
  });

  test("initial state should have default values", () {
    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.isSuccess, false);
    expect(viewModel.state.errorMessage, '');
  });

  test("emit success state when response is ApiSuccessResult", () async {
    final successData = LogoutEntity(message: '');
    final successResult = ApiSuccessResult<LogoutEntity>(data: successData);

    when(useCase.call()).thenAnswer((_) async => successResult);

    await viewModel.doIntent(SubmitLogoutEvent());

    verify(useCase.call()).called(1);

    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.logoutEntity, successData);
    expect(viewModel.state.isSuccess, true);
    expect(viewModel.state.errorMessage, '');
  });

  test("emit error state when response is ApiErrorResult", () async {
    final errorResult = ApiErrorResult<LogoutEntity>(
      failure: ServerFailure(errorMessage: "Logout failed"),
    );

    when(useCase.call()).thenAnswer((_) async => errorResult);

    await viewModel.doIntent(SubmitLogoutEvent());

    verify(useCase.call()).called(1);

    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.logoutEntity, null);
    expect(viewModel.state.isSuccess, false);
    expect(viewModel.state.errorMessage, "Logout failed");
  });
}
