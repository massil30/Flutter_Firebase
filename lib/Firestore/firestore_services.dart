import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/Firestore/docs_constant.dart';
import 'user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection(userCollection).doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String id) async {
    DocumentSnapshot doc = await _db.collection(userCollection).doc(id).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<List<UserModel>> get_all_Users() async {
    QuerySnapshot snapshot = await _db.collection(userCollection).get();
    return snapshot.docs
        .map((doc) =>
            UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updateUser(UserModel user) async {
    await _db.collection(userCollection).doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _db.collection(userCollection).doc(id).delete();
  }
}
