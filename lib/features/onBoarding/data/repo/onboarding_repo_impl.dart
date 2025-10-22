import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/onBoarding/data/sources/onboarding_local_ds.dart';
import 'package:super_fitness_app/features/onBoarding/domain/repo/onboarding_repo.dart';

@Injectable(as: OnboardingRepo)
class OnboardingRepoImpl implements OnboardingRepo {
  OnboardingLocalDataSource onboardingDataSource;
  OnboardingRepoImpl({required this.onboardingDataSource});
  @override
  Future<void> setOnboardingAsSeen() async {
    await onboardingDataSource.setOnboardingAsSeen();
  }
}
