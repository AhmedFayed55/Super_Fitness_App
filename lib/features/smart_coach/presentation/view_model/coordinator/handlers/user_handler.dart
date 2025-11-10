import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_data_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';

class UserHandler {
  final GetUserDataUseCase getUserDataUseCase;
  final void Function(SmartChatState) emit;
  final SmartChatState Function() getState;
  final Future<void> Function() loadUserChats;

  UserHandler({
    required this.getUserDataUseCase,
    required this.emit,
    required this.getState,
    required this.loadUserChats,
  });

  Future<void> loadUserData() async {
    emit(getState().copyWith(isLoadingUser: true, error: null));

    final result = await getUserDataUseCase.call();

    switch (result) {
      case ApiSuccessResult():
        emit(
          getState().copyWith(
            user: result.data.user,
            isLoadingUser: false,
            error: null,
          ),
        );
        await loadUserChats();
        break;
      case ApiErrorResult():
        emit(
          getState().copyWith(
            isLoadingUser: false,
            error: result.failure.errorMessage,
          ),
        );
        break;
    }
  }
}
