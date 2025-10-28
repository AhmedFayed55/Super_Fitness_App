import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/login/data/data_sources/login_screen_ds_impl.dart';
import 'package:super_fitness_app/features/auth/login/data/models/request/login_request_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/login_response_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/user_response_dto.dart';

import 'login_screen_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late ApiServices apiService;
  late LoginScreenDataSourceImpl dataSource;
  late LoginResponseDto loginResponseDto;
  late LoginRequestDto requestDto;

  setUpAll(() {
    apiService = MockApiServices();
    dataSource = LoginScreenDataSourceImpl(apiService);
    requestDto = const LoginRequestDto(
      email: "ahmed@qa.com",
      password: "dkbjsadvs",
    );
    loginResponseDto = const LoginResponseDto(
      message: "Success",
      token: "token",
      user: UserResponseDto(id: "12", firstName: "Ahmed"),
    );
  });

  test('success case for login returns LoginResponseDto', () async {
    when(
      apiService.login(requestDto),
    ).thenAnswer((_) async => loginResponseDto);

    var result = await dataSource.login(requestDto);

    verify(apiService.login(requestDto)).called(1);

    expect(result, isA<LoginResponseDto>());
    expect(result.message, equals(loginResponseDto.message));
    expect(result.user, isNotNull);
    expect(result.user, isA<UserResponseDto>());
  });
}
