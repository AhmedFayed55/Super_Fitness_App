import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/helpers/shared_pref.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'onboarding_local_ds.dart';

@Injectable(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPrefHelper _sharedPrefHelper;

  OnboardingLocalDataSourceImpl(this._sharedPrefHelper);

  @override
  Future<void> setOnboardingAsSeen() async {
    await _sharedPrefHelper.saveData(
      key: AppConstants.isOnBoardingSeen,
      val: true,
    );
  }
}
