import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/helpers/shared_pref.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

@lazySingleton
class LanguageInterceptor extends Interceptor {
  final SharedPrefHelper sharedPrefHelper;

  LanguageInterceptor(this.sharedPrefHelper);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final langCode = sharedPrefHelper.getData(key: AppConstants.languageCode) ?? 'en';
    options.headers['Accept-Language'] = langCode;
    handler.next(options);
  }
}
