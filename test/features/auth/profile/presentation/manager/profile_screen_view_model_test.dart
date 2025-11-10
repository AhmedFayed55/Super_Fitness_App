import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/auth/profile/domain/use_cases/get_help_screen_content_use_case.dart';
import 'package:super_fitness_app/features/auth/profile/domain/use_cases/get_privacy_screen_content_use_case.dart';
import 'package:super_fitness_app/features/auth/profile/domain/use_cases/get_security_screen_content_use_case.dart';
import 'package:super_fitness_app/features/auth/profile/domain/use_cases/get_user_data_use_case.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/manager/profile_screen_event.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/manager/profile_screen_state.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/manager/profile_screen_view_model.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart'
as help;
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart'
as privacy;
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart'
as security;
import 'profile_screen_view_model_test.mocks.dart';

@GenerateMocks([
  GetUserDataUseCase,
  GetPrivacyScreenContentUseCase,
  SecurityScreenContentUseCase,
  HelpScreenContentUseCase,
])
void main() {
  late GetUserDataUseCase mockGetUserDataUseCase;
  late GetPrivacyScreenContentUseCase mockPrivacyUseCase;
  late SecurityScreenContentUseCase mockSecurityUseCase;
  late HelpScreenContentUseCase mockHelpUseCase;
  late ProfileScreenViewModel viewModel;

  setUp(() {
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockPrivacyUseCase = MockGetPrivacyScreenContentUseCase();
    mockSecurityUseCase = MockSecurityScreenContentUseCase();
    mockHelpUseCase = MockHelpScreenContentUseCase();
    viewModel = ProfileScreenViewModel(
      mockGetUserDataUseCase,
      mockPrivacyUseCase,
      mockSecurityUseCase,
      mockHelpUseCase,
    );
  });

  group('ProfileScreenViewModel Tests', () {
    final mockUser = UserDataResponseEntity(
        firstName: "john",
        lastName: "doe",
        id: "4154",
        photo: "photo@example.png",
        email: "jhon@yahoo.com",
        age: 22,
        goal: "lose weight",
        height: 180,
        weight: 75,
        activityLevel: "hard",
        createdAt: "10-10-2020",
        gender: "male"
    );

    final helpList = [
      help.HelpScreenResponseEntity(
        section: 'general',
        title: 'FAQ',
        content: 'Some help content',
        style: help.StyleEntity(fontSize: 16, color: '#000000'),
        contacts: [
          help.ContactEntity(
            id: '1',
            method: 'email',
            details: 'support@example.com',
            value: 'Contact us via email',
            style: help.ContactStyleEntity(
              method: help.StyleEntity(color: '#333333'),
              details: help.StyleEntity(color: '#777777'),
            ),
          )
        ],
        faqs: [
          help.FaqEntity(id: '1', question: 'How to use?', answer: 'Just open app'),
        ],
      ),
    ];

    final privacyList = [
      privacy.PrivacyPolicyEntity(
        section: 'data',
        title: 'Data Usage',
        content: ['We collect minimal data'],
        style: privacy.StyleEntity(fontSize: 14, color: '#111111'),
      ),
    ];

    final securityList = [
      security.SecurityRolesConfigEntity(
        section: 'roles',
        title: 'Admin Role',
        description: 'Full access',
        style: security.StyleEntity(color: '#FF0000'),
        roleId: '1',
        name: 'Admin',
        permissions: [
          security.PermissionEntity(
              key: 'READ', name: 'Read Access', description: 'Can read data'),
        ],
      ),
    ];

    test('Initial state should be default', () {
      expect(viewModel.state, const ProfileScreenState());
    });

    test('LoadUserDataEvent success updates user data', () async {
      final successResult = ApiSuccessResult<UserDataResponseEntity>(data: mockUser);
      provideDummy<ApiResult<UserDataResponseEntity>>(successResult);

      when(mockGetUserDataUseCase()).thenAnswer((_) async => successResult);

      await viewModel.doIntent(LoadUserDataEvent());

      verify(mockGetUserDataUseCase()).called(1);
      expect(viewModel.state.userData, mockUser);
      expect(viewModel.state.userDataErrorMsg, null);
    });

    test('LoadUserDataEvent failure updates error message', () async {
      final errorResult = ApiErrorResult<UserDataResponseEntity>(
        failure: ServerFailure(errorMessage: 'User fetch failed'),
      );
      provideDummy<ApiResult<UserDataResponseEntity>>(errorResult);

      when(mockGetUserDataUseCase()).thenAnswer((_) async => errorResult);

      await viewModel.doIntent(LoadUserDataEvent());

      expect(viewModel.state.userData, null);
      expect(viewModel.state.userDataErrorMsg, equals(errorResult.failure.errorMessage));
    });

    test('LoadHelpContentEvent success updates help content', () async {
      final success = ApiSuccessResult<List<help.HelpScreenResponseEntity>>(data: helpList);
      provideDummy<ApiResult<List<help.HelpScreenResponseEntity>>>(success);

      when(mockHelpUseCase()).thenAnswer((_) async => success);

      await viewModel.doIntent(LoadHelpContentEvent());

      verify(mockHelpUseCase()).called(1);
      expect(viewModel.state.helpContent, helpList);
      expect(viewModel.state.isLoadingContent, false);
    });

    test('LoadPrivacyContentEvent success updates privacy content', () async {
      final success = ApiSuccessResult<List<privacy.PrivacyPolicyEntity>>(data: privacyList);
      provideDummy<ApiResult<List<privacy.PrivacyPolicyEntity>>>(success);

      when(mockPrivacyUseCase()).thenAnswer((_) async => success);

      await viewModel.doIntent(LoadPrivacyContentEvent());

      verify(mockPrivacyUseCase()).called(1);
      expect(viewModel.state.privacyContent, privacyList);
    });

    test('LoadSecurityContentEvent success updates security content', () async {
      final success =
      ApiSuccessResult<List<security.SecurityRolesConfigEntity>>(data: securityList);
      provideDummy<ApiResult<List<security.SecurityRolesConfigEntity>>>(success);

      when(mockSecurityUseCase()).thenAnswer((_) async => success);

      await viewModel.doIntent(LoadSecurityContentEvent());

      verify(mockSecurityUseCase()).called(1);
      expect(viewModel.state.securityContent, securityList);
    });

    test('Content load failure updates error message', () async {
      final error = ApiErrorResult<List<help.HelpScreenResponseEntity>>(
        failure: ServerFailure(errorMessage: 'Network error'),
      );
      provideDummy<ApiResult<List<help.HelpScreenResponseEntity>>>(error);

      when(mockHelpUseCase()).thenAnswer((_) async => error);

      await viewModel.doIntent(LoadHelpContentEvent());

      expect(viewModel.state.contentErrorMsg, equals(error.failure.errorMessage));
      expect(viewModel.state.helpContent, null);
    });
  });
}
