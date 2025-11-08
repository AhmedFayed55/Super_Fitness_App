import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/help/help_screen_content_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class HelpScreenContentUseCase {
  final ProfileRepo _repo;
  HelpScreenContentUseCase(this._repo);

  Future<ApiResult<List<HelpScreenContentEntity>>> call() =>
      _repo.getHelpScreenContent();
}
