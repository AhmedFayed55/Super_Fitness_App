import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/onBoarding/domain/repo/onboarding_repo.dart';

@injectable
class SetOnboardingAsSeenUsecase {
  final OnboardingRepo _onboardingRepo;
  SetOnboardingAsSeenUsecase(this._onboardingRepo);
  Future<void> invoke() => _onboardingRepo.setOnboardingAsSeen();
}
