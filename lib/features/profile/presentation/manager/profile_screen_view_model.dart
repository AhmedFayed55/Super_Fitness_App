import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_help_screen_content_use_case.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_privacy_screen_content_use_case.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_security_screen_content_use_case.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_user_data_use_case.dart';
import 'package:super_fitness_app/features/profile/presentation/manager/profile_screen_event.dart';
import 'package:super_fitness_app/features/profile/presentation/manager/profile_screen_state.dart';

@injectable
class ProfileScreenViewModel extends Cubit<ProfileScreenState> {
  ProfileScreenViewModel(
    this._getUserDataUseCase,
    this._getPrivacyScreenContentUseCase,
    this._getSecurityScreenContentUseCase,
    this._helpScreenContentUseCase,
  ) : super(const ProfileScreenState());

  final HelpScreenContentUseCase _helpScreenContentUseCase;
  final GetPrivacyScreenContentUseCase _getPrivacyScreenContentUseCase;
  final SecurityScreenContentUseCase _getSecurityScreenContentUseCase;
  final GetUserDataUseCase _getUserDataUseCase;

  Future<void> doIntent(ProfileScreenEvent event) async {
    switch (event) {
      case LoadUserDataEvent():
        await _getUserData();
        break;
      case LoadPrivacyContentEvent():
        await _fetchContent(ContentType.privacy);
        break;
      case LoadSecurityContentEvent():
        await _fetchContent(ContentType.security);
        break;
      case LoadHelpContentEvent():
        await _fetchContent(ContentType.help);
        break;
    }
  }

  Future<void> _getUserData() async {
    emit(
      state.copyWith(
        isLoadingUserData: true,
        userDataErrorMsg: null,
        userData: null,
      ),
    );
    final result = await _getUserDataUseCase();
    switch (result) {
      case ApiSuccessResult<UserDataResponseEntity>():
        emit(state.copyWith(isLoadingUserData: false, userData: result.data));
      case ApiErrorResult<UserDataResponseEntity>():
        emit(
          state.copyWith(
            isLoadingUserData: false,
            userDataErrorMsg: result.failure.errorMessage,
          ),
        );
    }
  }

  Future<void> _fetchContent(ContentType type) async {
    emit(state.copyWith(isLoadingContent: true, contentErrorMsg: null));

    final result = switch (type) {
      ContentType.help => await _helpScreenContentUseCase(),
      ContentType.privacy => await _getPrivacyScreenContentUseCase(),
      ContentType.security => await _getSecurityScreenContentUseCase(),
    };

    switch (result) {
      case ApiSuccessResult():
        switch (type) {
          case ContentType.help:
            emit(
              state.copyWith(
                isLoadingContent: false,
                helpContent: result.data as List<HelpScreenResponseEntity>,
              ),
            );
          case ContentType.privacy:
            emit(
              state.copyWith(
                isLoadingContent: false,
                privacyContent: result.data as List<PrivacyPolicyEntity>,
              ),
            );
          case ContentType.security:
            emit(
              state.copyWith(
                isLoadingContent: false,
                securityContent: result.data as List<SecurityRolesConfigEntity>,
              ),
            );
        }
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoadingContent: false,
            contentErrorMsg: result.failure.errorMessage,
          ),
        );
    }
  }
}
