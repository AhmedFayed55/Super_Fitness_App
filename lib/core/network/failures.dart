import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

class Failure {
  final String errorMessage;
  final String code;
  Failure({required this.errorMessage, this.code = 'No Status Code Found'});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage, super.code});

  factory ServerFailure.fromDioError({required DioException dioException}) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: "Connection timeout with API server.",
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: "Send timeout with API server.");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: "Receive timeout with API server.");
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage:
              "Connection to API server failed due to an invalid certificate.",
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage:
              "Connection to API was cancelled. Please try again later.",
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage:
              "Connection to API server failed due to an internet connection issue.",
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: "Unexpected error occurred. Please try again later.",
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response);
    }
  }

  factory ServerFailure.fromResponse(Response? response) {
    if (response == null) {
      return ServerFailure(errorMessage: "No response received from server.");
    }

    switch (response.statusCode) {
      case 404:
        return ServerFailure(errorMessage: "Resource not found", code: '404');
      case 400:
        return ServerFailure(errorMessage: "Resource not found", code: '400');
      case 500:
        return ServerFailure(
          errorMessage: "Server error. Please try again later.",
          code: '500',
        );
      default:
        return ServerFailure(
          errorMessage: response.data["error"],
          code: response.data["code"].toString(),
        );
    }
  }

  factory ServerFailure.fromFirebaseError({
    required FirebaseException exception,
  }) {
    switch (exception.code) {
      case 'permission-denied':
        return ServerFailure(
          errorMessage: "You don't have permission to perform this action.",
          code: exception.code,
        );
      case 'unavailable':
        return ServerFailure(
          errorMessage: "Service is currently unavailable. Try again later.",
          code: exception.code,
        );
      case 'not-found':
        return ServerFailure(
          errorMessage: "Requested document was not found.",
          code: exception.code,
        );
      case 'already-exists':
        return ServerFailure(
          errorMessage: "The document already exists.",
          code: exception.code,
        );
      case 'cancelled':
        return ServerFailure(
          errorMessage: "The operation was cancelled.",
          code: exception.code,
        );
      default:
        return ServerFailure(
          errorMessage: exception.message ?? "Unknown Firebase error occurred.",
          code: exception.code,
        );
    }
  }
}
