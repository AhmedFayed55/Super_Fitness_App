import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/onBoarding/domain/repo/onboarding_repo.dart';

@injectable
class SetOnboardingAsSeenUsecase {
  final OnboardingRepo onboardingRepo;
  SetOnboardingAsSeenUsecase(this.onboardingRepo);
  Future<void> invoke() => onboardingRepo.setOnboardingAsSeen();
}
