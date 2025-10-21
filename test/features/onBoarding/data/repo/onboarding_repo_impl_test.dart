import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/onBoarding/data/sources/onboarding_ds.dart';
import 'package:super_fitness_app/features/onBoarding/data/repo/onboarding_repo_impl.dart';

import 'onboarding_repo_impl_test.mocks.dart';

@GenerateMocks([OnboardingDataSource])
void main() {
  late OnboardingRepoImpl repo;
  late MockOnboardingDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockOnboardingDataSource();
    repo = OnboardingRepoImpl(onboardingDataSource: mockDataSource);
  });

  group('OnboardingRepoImpl', () {
    test('should call onboardingDataSource.setOnboardingAsSeen once', () async {
      // arrange
      when(
        mockDataSource.setOnboardingAsSeen(),
      ).thenAnswer((_) async => Future.value());

      // act
      await repo.setOnboardingAsSeen();

      // assert
      verify(mockDataSource.setOnboardingAsSeen()).called(1);
    });
  });
}
