import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseService {
  final FirebaseFirestore _firestore;

  FirebaseService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  Future<void> addData(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionPath).doc(docId).set(data);
  }

  Future<DocumentSnapshot> getData(String collectionPath, String docId) async {
    return await _firestore.collection(collectionPath).doc(docId).get();
  }

  Future<void> updateData(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  Future<void> deleteData(String collectionPath, String docId) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }

  Stream<DocumentSnapshot> streamData(String collectionPath, String docId) {
    return _firestore.collection(collectionPath).doc(docId).snapshots();
  }

  Stream<QuerySnapshot> streamCollection(String collectionPath) {
    return _firestore.collection(collectionPath).snapshots();
  }
}
