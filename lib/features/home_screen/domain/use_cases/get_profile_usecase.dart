  import 'package:super_fitness_app/core/network/api_results.dart';
  import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
  import 'package:super_fitness_app/features/profile/domain/repositories/profile_repo.dart';
  import 'package:injectable/injectable.dart';

  @injectable
  class GetUserProfileUseCase {
    final ProfileRepo _repo;

    GetUserProfileUseCase(this._repo);

    Future<ApiResult<UserDataResponseEntity>> call() => _repo.getUserData();
  }
