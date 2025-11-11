import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/domain/usecase/edit_profile_usecase.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_event.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUsecase _editProfileUsecase;

  late UserEntity originalUser;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditProfileCubit(this._editProfileUsecase) : super(const EditProfileState());

  void doIntant(EditProfileEvent event) {
    switch (event) {
      case EditProfileDataEvent():
        _saveProfile();
        return;

      case ChangeActivityEvent():
        _changeActivity(event.activityLevel);
        return;

      case ChangeGoalEvent():
        _changeGoal(event.goal);
        return;

      case ChangeWeightEvent():
        _changeWeight(event.weight);
        return;

      case LoadUserDataEvent():
        loadUser(event.user);
        return;

      case ChangeFirstNameEvent():
        _changeFirstName(event.newFirstName);
        return;

      case ChangeLastNameEvent():
        _changeLastName(event.newLastName);
        return;

      case ChangeEmailEvent():
        _changeEmail(event.email);
        return;
    }
  }

  bool get canSave {
    final u = state.user!;
    final o = originalUser;

    final hasDifference = u != o;

    final hasEmptyFields =
        u.firstName.isEmpty || u.lastName.isEmpty || u.email.isEmpty;

    return hasDifference && !hasEmptyFields;
  }

  Future<void> _saveProfile() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    var result = await _editProfileUsecase.invoke(state.user!);

    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(isSuccess: true, isLoading: false));
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure.errorMessage,
          ),
        );
        break;
    }
  }

  void loadUser(UserEntity user) {
    originalUser = user;
    emit(state.copyWith(user: user, isDataChanged: false));
  }

  void _changeWeight(int newWeight) {
    emit(
      state.copyWith(
        user: state.user?.copyWith(weight: newWeight),
        isDataChanged: originalUser.weight != newWeight,
      ),
    );
  }

  void _changeGoal(String newGoal) {
    emit(
      state.copyWith(
        user: state.user?.copyWith(goal: newGoal),
        isDataChanged: originalUser.goal != newGoal,
      ),
    );
  }

  void _changeActivity(String newActivity) {
    emit(
      state.copyWith(
        user: state.user?.copyWith(activityLevel: newActivity),
        isDataChanged: originalUser.activityLevel != newActivity,
      ),
    );
  }

  void _changeFirstName(String newFirstName) {
    emit(
      state.copyWith(
        user: state.user?.copyWith(firstName: newFirstName),
        isDataChanged: originalUser.firstName != newFirstName,
      ),
    );
  }

  void _changeLastName(String newLastName) {
    emit(
      state.copyWith(
        isDataChanged: originalUser.lastName != newLastName,

        user: state.user?.copyWith(lastName: newLastName),
      ),
    );
  }

  void _changeEmail(String newEmail) {
    emit(
      state.copyWith(
        isDataChanged: originalUser.email != newEmail,
        user: state.user?.copyWith(email: newEmail),
      ),
    );
  }

  void navigatToEditsScreen(Edits edit) {
    emit(state.copyWith(selectedEdits: edit));
  }
}
