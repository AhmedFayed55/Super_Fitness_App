import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';

class RegisterState extends Equatable{
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final RegisterRequestModel? registerRequestModel;

  const RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.registerRequestModel,
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    RegisterRequestModel? registerRequestModel,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      registerRequestModel: registerRequestModel ?? this.registerRequestModel,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isError, registerRequestModel];
}
