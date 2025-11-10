import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/onBoarding/domain/repo/onboarding_repo.dart';
import 'package:super_fitness_app/features/onBoarding/domain/usecase/set_onboarding_as_seen_usecase.dart';

import 'set_onboarding_as_seen_usecase_test.mocks.dart';

@GenerateMocks([OnboardingRepo])
void main() {
  late SetOnboardingAsSeenUsecase usecase;
  late MockOnboardingRepo mockRepo;

  setUp(() {
    mockRepo = MockOnboardingRepo();
    usecase = SetOnboardingAsSeenUsecase(mockRepo);
  });

  test('should call onboardingRepo.setOnboardingAsSeen once', () async {
    when(
      mockRepo.setOnboardingAsSeen(),
    ).thenAnswer((_) async => Future.value());

    await usecase.invoke();

    verify(mockRepo.setOnboardingAsSeen()).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
