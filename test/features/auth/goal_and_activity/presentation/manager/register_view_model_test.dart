// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:super_fitness_app/core/network/api_results.dart';
// import 'package:super_fitness_app/core/network/failures.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/user_dto_entity.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/domain/use_cases/register_use_case.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_event.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';
// import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_view_model.dart';
//
// import 'register_view_model_test.mocks.dart';
//
// @GenerateMocks([RegisterUseCase])
void main() {
//   late MockRegisterUseCase mockRegisterUseCase;
//   late RegisterViewModel viewModel;
//   late RegisterRequestModel requestModel;
//   late RegisterResponseEntity responseEntity;
//   late UserDtoEntity userDtoEntity;
//
//   setUp(() {
//     mockRegisterUseCase = MockRegisterUseCase();
//     viewModel = RegisterViewModel(registerUseCase: mockRegisterUseCase);
//     requestModel = RegisterRequestModel(
//       firstName: "firstName",
//       lastName: "lastName",
//       email: "email",
//       password: "password",
//     );
//     userDtoEntity = UserDtoEntity(id: "id", firstName: "firstName");
//     responseEntity = RegisterResponseEntity(
//       token: "token",
//       message: "success",
//       userDtoEntity: userDtoEntity,
//     );
//   });
//
//   blocTest<RegisterViewModel, RegisterState>(
//     "emits [loading, success] when register succeeds",
//     build: () {
//       provideDummy<ApiResult<RegisterResponseEntity>>(
//         ApiSuccessResult<RegisterResponseEntity>(data: responseEntity),
//       );
//       when(
//         mockRegisterUseCase.register(any),
//       ).thenAnswer((_) async => ApiSuccessResult(data: responseEntity));
//       return viewModel;
//     },
//     act: (cubit) =>
//         cubit.doIntent(SubmitRegisterEvent(activityLevel: '')),
//     expect: () => [
//       const RegisterState(
//         isLoading: true,
//         isSuccess: false,
//         isError: false,
//         registerRequestModel: null,
//       ),
//       RegisterState(
//         isLoading: false,
//         isSuccess: true,
//         isError: false,
//         registerRequestModel: requestModel,
//       ),
//     ],
//     verify: (_) {
//       verify(mockRegisterUseCase.register(requestModel)).called(1);
//     },
//   );
//
//   blocTest<RegisterViewModel, RegisterState>(
//     "emits [loading, error] when register fail",
//     build: () {
//       provideDummy<ApiResult<RegisterResponseEntity>>(
//         ApiErrorResult<RegisterResponseEntity>(
//           failure: Failure(errorMessage: "error"),
//         ),
//       );
//       when(mockRegisterUseCase.register(any)).thenAnswer(
//         (_) async => ApiErrorResult(failure: Failure(errorMessage: "error")),
//       );
//       return viewModel;
//     },
//     act: (cubit) =>
//         cubit.doIntent(SubmitRegisterEvent(activityLevel: '')),
//     expect: () => [
//       const RegisterState(
//         isLoading: true,
//         isSuccess: false,
//         isError: false,
//         registerRequestModel: null,
//       ),
//       const RegisterState(
//         isLoading: false,
//         isSuccess: false,
//         isError: true,
//         registerRequestModel: null,
//       ),
//     ],
//     verify: (_) {
//       verify(mockRegisterUseCase.register(requestModel)).called(1);
//     },
//   );
}
