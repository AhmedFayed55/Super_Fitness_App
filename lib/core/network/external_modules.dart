import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness_app/core/services/language_interceptor.dart';
import '../di/di.dart';
import '../services/token_interceptor.dart';
import 'network_constants.dart';

@module
abstract class ExternalModules {
  @lazySingleton
  Dio provideDio() {
    Dio dio = Dio();
    dio.options.baseUrl = NetworkConstants.baseUrl;
    dio.options.headers = {'Content-Type': 'application/json'};
    dio.interceptors.add(getIt.get<PrettyDioLogger>());
    dio.interceptors.add(getIt.get<LanguageInterceptor>());
    dio.interceptors.add(getIt.get<TokenInterceptor>());
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    );
  }

  @preResolve
  Future<SharedPreferences> get provideSharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() {
    return const FlutterSecureStorage();
  }

  @lazySingleton
  InternetConnectionChecker provideInternetConnectionChecker() =>
      InternetConnectionChecker.instance;
}
