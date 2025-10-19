import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'failures.dart';

sealed class ApiResult<T> {}

class ApiSuccessResult<T> extends ApiResult<T> {
  final T data;

  ApiSuccessResult({required this.data});
}

class ApiErrorResult<T> extends ApiResult<T> {
  final Failure failure;

  ApiErrorResult({required this.failure});
}

Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  final bool isConnected =
      await InternetConnectionChecker.instance.hasConnection;
  if (!isConnected) {
    return ApiErrorResult<T>(failure: Failure(errorMessage: 'no internet'));
  }

  try {
    final result = await apiCall();
    return ApiSuccessResult<T>(data: result);
  } on DioException catch (dioError) {
    return ApiErrorResult<T>(
      failure: ServerFailure.fromDioError(dioException: dioError),
    );
  } catch (error) {
    return ApiErrorResult<T>(failure: Failure(errorMessage: error.toString()));
  }
}
