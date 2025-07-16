import 'package:flutter_firebase/Firestore/docs_constant.dart';

class UserModel {
  final String? id;
  final String full_name;
  final String photo_url;
  final String email;
  final String function;

  UserModel({
    this.id,
    required this.full_name,
    required this.photo_url,
    required this.email,
    required this.function,
  });

  // Convert Firestore doc to UserModel
  factory UserModel.fromMap(Map<String, dynamic> data, String docId) {
    return UserModel(
      id: docId,
      full_name: data[userFullName] ?? '',
      photo_url: data[userPhotoUrl] ?? '',
      email: data[userEmail] ?? '',
      function: data[userFunction] ?? '',
    );
  }

  // Convert UserModel to Map
  Map<String, dynamic> toMap() {
    return {
      userFullName: full_name,
      userPhotoUrl: photo_url,
      userEmail: email,
      userFunction: function,
      // Remove Id Because I won't push it Firestore auto generates it
    };
  }
}
