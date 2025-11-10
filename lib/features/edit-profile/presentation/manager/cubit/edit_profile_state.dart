part of 'edit_profile_cubit.dart';

enum Edits { none, weight, goal, activity }

class EditProfileState extends Equatable {
  final UserEntity? user;
  final String errorMessage;
  final bool isSuccess;
  final bool isLoading;
  final Edits selectedEdits;
  final bool isDataChanged;

  const EditProfileState({
    this.user,
    this.errorMessage = '',
    this.isSuccess = false,
    this.isLoading = false,
    this.selectedEdits = Edits.none,
    this.isDataChanged = false,
  });

  EditProfileState copyWith({
    UserEntity? user,
    String? errorMessage,
    bool? isSuccess,
    bool? isLoading,
    Edits? selectedEdits,
    bool? isDataChanged,
  }) {
    return EditProfileState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      selectedEdits: selectedEdits ?? this.selectedEdits,
      isDataChanged: isDataChanged ?? this.isDataChanged,
    );
  }

  @override
  List<Object?> get props => [
    user,
    errorMessage,
    isSuccess,
    isLoading,
    selectedEdits,
    isDataChanged,
  ];
}
