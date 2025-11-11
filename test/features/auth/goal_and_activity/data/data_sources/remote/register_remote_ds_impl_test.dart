import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/data_sources/remote/register_remote_ds_impl.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';
import 'register_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late UserDto userDto;
  late RegisterRemoteDataSourceImpl registerRemoteDataSourceImpl;

  setUp(() {
    mockApiServices = MockApiServices();

    registerRemoteDataSourceImpl = RegisterRemoteDataSourceImpl(
      apiServices: mockApiServices,
    );
  });

  test(
    "register() Should return RegisterResponseModel when Success",
    () async {
      // arrange
      userDto = UserDto(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
      );
      final registerRequestModel = RegisterRequestModel(
        email: "email",
        password: "password",
      );
      final registerResponseModel = RegisterResponseModel(userDto: userDto);

      when(
        mockApiServices.register(registerRequestModel),
      ).thenAnswer((_) async => registerResponseModel);

      // act
      final result = await registerRemoteDataSourceImpl.register(
        registerRequestModel,
      );

      // assert
      expect(result, equals(registerResponseModel));
      verify(mockApiServices.register(registerRequestModel)).called(1);
    },
  );
}
