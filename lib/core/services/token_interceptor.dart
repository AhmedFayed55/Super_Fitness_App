import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/services/token_service.dart';
import '../di/di.dart';
import '../network/network_constants.dart';

@injectable
class TokenInterceptor extends Interceptor {
  final TokenService tokenService = getIt.get<TokenService>();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await tokenService.getToken();
    if (token != null) {
      options.headers[NetworkConstants.authorization] =
          "${NetworkConstants.bearer} $token";
    }
    return super.onRequest(options, handler);
  }
}
