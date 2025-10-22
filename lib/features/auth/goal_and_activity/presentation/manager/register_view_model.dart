import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/use_cases/register_use_case.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_event.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/manager/register_state.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterViewModel({required this.registerUseCase}) : super(RegisterState());

  Future<void> doIntent(RegisterEvent event) async {
    switch (event) {
      case SubmitRegisterEvent():
        await _submitRegister(event.registerRequestModel);
        break;
    }
  }

  Future<void> _submitRegister(
    RegisterRequestModel registerRequestModel,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        isError: false,
        registerRequestModel: null,
      ),
    );
    var registerResponseEntity = await registerUseCase.register(
      registerRequestModel,
    );
    switch (registerResponseEntity) {
      case ApiSuccessResult<RegisterResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            isError: false,
            registerRequestModel: registerRequestModel,
          ),
        );
        break;
      case ApiErrorResult<RegisterResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            isError: true,
            registerRequestModel: null,
          ),
        );
    }
  }
}
