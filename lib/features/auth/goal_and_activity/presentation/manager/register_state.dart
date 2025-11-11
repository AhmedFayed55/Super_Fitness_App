import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? goalSelected;
  final String? activitySelected;
  final RegisterRequestModel? registerRequestModel;
  final int age;
  final int weight;
  final int height;
  final String? gender;
  final bool showToast;

  const RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.goalSelected,
    this.activitySelected,
    this.registerRequestModel,
    this.showToast = false,
    this.age = 25,
    this.weight = 70,
    this.height = 170,
    this.gender,
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? showToast,
    String? goalSelected,
    String? activitySelected,
    RegisterRequestModel? registerRequestModel,
    int? age,
    int? weight,
    int? height,
    String? gender,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      goalSelected: goalSelected ?? this.goalSelected,
      activitySelected: activitySelected ?? this.activitySelected,
      registerRequestModel: registerRequestModel ?? this.registerRequestModel,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      showToast: showToast ?? this.showToast,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isError,
    goalSelected,
    activitySelected,
    registerRequestModel,
    age,
    weight,
    height,
    gender,
  ];
}
