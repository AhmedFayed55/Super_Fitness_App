import 'package:cloud_firestore/cloud_firestore.dart';

import 'failures.dart';

sealed class FirebaseResult<T> {}

class FirebaseSuccessResult<T> extends FirebaseResult<T> {
  final T data;

  FirebaseSuccessResult({required this.data});
}

class FirebaseErrorResult<T> extends FirebaseResult<T> {
  final Failure failure;

  FirebaseErrorResult({required this.failure});
}

Future<FirebaseResult<T>> safeFirebaseCall<T>(
  Future<T> Function() firebaseCall,
) async {
  try {
    final result = await firebaseCall();
    return FirebaseSuccessResult<T>(data: result);
  } on FirebaseException catch (firebaseError) {
    return FirebaseErrorResult<T>(
      failure: Failure(
        errorMessage: firebaseError.message ?? "Unknown Firebase error",
      ),
    );
  } catch (error) {
    return FirebaseErrorResult<T>(
      failure: Failure(errorMessage: error.toString()),
    );
  }
}
