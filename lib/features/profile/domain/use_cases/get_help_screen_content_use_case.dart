import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/help/help_screen_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class HelpScreenContentUseCase {
  final ProfileRepo _repo;
  HelpScreenContentUseCase(this._repo);

  Future<ApiResult<List<HelpScreenResponseEntity>>> call() =>
      _repo.getHelpScreenContent();
}
