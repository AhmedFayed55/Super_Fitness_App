import 'package:flutter/material.dart';
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
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController firstName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  TextEditingController emailController = TextEditingController(text: "mostafa111@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "Mostafa@123");
  TextEditingController firstName = TextEditingController(text: "MostafaMo");
  TextEditingController lastName = TextEditingController(text: "Amer");
  PageController pageController = PageController();

  RegisterViewModel({required this.registerUseCase}) : super( const RegisterState());

  Future<void> doIntent(RegisterEvent event) async {
    switch (event) {
      case SubmitRegisterEvent(: final activityLevel):
        await _submitRegister(activityLevel);
        break;
      case OnSelectedGoalEvent():
          _onSelectedGoal(event.goal);
        break;
      case OnSelectedActivityEvent(: final activity):
        _onActivityGoal(activity);
        break;
      case SaveAgeEvent():
        _saveAge(event.age);
        break;
      case SaveWeightEvent():
        _saveWeight(event.weight);
        break;
      case SaveHeightEvent():
        _saveHeight(event.height);
        break;
      case SaveGenderEvent():
        _saveGender(event.gender);
        break;
    }
  }

  Future<void> _submitRegister(
      String activityLevel,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        isError: false,
        showToast: false
      ),
    );
    var registerResponseEntity = await registerUseCase.register(
      RegisterRequestModel(
        firstName: firstName.text,
        lastName: lastName.text,
        email: emailController.text,
        password: passwordController.text,
        age: state.age,
        weight: state.weight,
        height: state.height,
        gender: state.gender,
        goal: state.goalSelected,
        activityLevel: activityLevel,
        rePassword: passwordController.text
      )
    );
    switch (registerResponseEntity) {
      case ApiSuccessResult<RegisterResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            isError: false,
          ),
        );
        break;
      case ApiErrorResult<RegisterResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            isError: true,
            showToast: true
          ),
        );
    }
  }

  void _onSelectedGoal(String? goal) {
    emit(state.copyWith(goalSelected: goal));
  }

  void _onActivityGoal(String? activity) {
    emit(state.copyWith(activitySelected: activity));
  }

  void _saveAge(int age) {
    emit(state.copyWith(age: age));
  }

  void _saveWeight(int weight) {
    emit(state.copyWith(weight: weight));
  }

  void _saveHeight(int height) {
    emit(state.copyWith(height: height));
  }

  void _saveGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

}
