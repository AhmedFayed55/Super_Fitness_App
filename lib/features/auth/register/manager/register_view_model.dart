import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_event.dart';
import 'package:super_fitness_app/features/auth/register/manager/register_state.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  RegisterViewModel() : super(RegisterState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  PageController pageController = PageController();
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstName.dispose();
    lastName.dispose();
    pageController.dispose();
    return super.close();
  }

  void doIntent(RegisterEvent event) {
    switch (event) {
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
