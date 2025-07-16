import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firestore/firestore_services.dart';
import 'package:flutter_firebase/Firestore/user_model.dart';

class Firestore_View extends StatefulWidget {
  const Firestore_View({super.key});

  @override
  State<Firestore_View> createState() => _Firestore_ViewState();
}

class _Firestore_ViewState extends State<Firestore_View> {
  FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firestoreService
              .createUser(UserModel(
                  full_name: 'John Doe',
                  photo_url: 'https://example.com/photo.jpg',
                  email: 'john.doe@example.com',
                  function: 'Developer'))
              .then((value) => print('User added successfully'));
        },
        child: const Text('Add User'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                firestoreService
                    .updateUser(UserModel(
                        full_name: 'Hello World',
                        photo_url: 'photo_url',
                        email: 'email',
                        function: 'function'))
                    .then((value) => print('User updated successfully'));
              },
              child: const Text('Update User')),
        ],
      ),
    );
  }
}
