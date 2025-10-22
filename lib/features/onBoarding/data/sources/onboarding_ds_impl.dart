import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/helpers/shared_pref.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'onboarding_ds.dart';

@Injectable(as: OnboardingDataSource)
class OnboardingDataSourceImpl implements OnboardingDataSource {
  SharedPrefHelper sharedPrefHelper;

  OnboardingDataSourceImpl(this.sharedPrefHelper);

  @override
  Future<void> setOnboardingAsSeen() async {
    await sharedPrefHelper.saveData(
      key: AppConstants.isOnBoardingSeen,
      val: true,
    );
  }
}
