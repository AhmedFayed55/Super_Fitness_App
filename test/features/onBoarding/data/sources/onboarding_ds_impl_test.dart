import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/helpers/shared_pref.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/onBoarding/data/sources/onboarding_ds_impl.dart';

import 'onboarding_ds_impl_test.mocks.dart';

@GenerateMocks([SharedPrefHelper])
void main() {
  late OnboardingDataSourceImpl dataSource;
  late MockSharedPrefHelper mockSharedPrefHelper;

  setUp(() {
    mockSharedPrefHelper = MockSharedPrefHelper();
    dataSource = OnboardingDataSourceImpl(mockSharedPrefHelper);
  });

  group('OnboardingDataSourceImpl', () {
    test(
      'should call SharedPrefHelper.saveData with correct key and value',
      () async {
        // arrange
        when(
          mockSharedPrefHelper.saveData(
            key: anyNamed('key'),
            val: anyNamed('val'),
          ),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.setOnboardingAsSeen();

        // assert
        verify(
          mockSharedPrefHelper.saveData(
            key: AppConstants.isOnBoardingSeen,
            val: true,
          ),
        ).called(1);
      },
    );
  });
}
