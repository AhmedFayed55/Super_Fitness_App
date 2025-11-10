import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/logout/data/data_source/logout_ds_imp.dart';
import 'package:super_fitness_app/features/auth/logout/data/model/logout_response_dto.dart';
import 'logout_ds_imp_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late LogoutDataSourceImp dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = LogoutDataSourceImp(mockApiServices);
  });

  group('LogoutDataSourceImp', () {
    test(
      'should call ApiServices.logout() and return LogoutResponseDto',
      () async {
        final mockResponse = LogoutResponseDto(message: "Logout success");
        when(mockApiServices.logout()).thenAnswer((_) async => mockResponse);

        final result = await dataSource.logoutDataSource();

        expect(result, isA<LogoutResponseDto>());
        expect(result.message, "Logout success");
        verify(mockApiServices.logout()).called(1);
      },
    );
  });
}
