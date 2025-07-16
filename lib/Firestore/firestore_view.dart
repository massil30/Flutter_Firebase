import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firestore/firestore_services.dart';
import 'package:flutter_firebase/Firestore/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
              .then((value) {
            print('User added successfully');

            setState(() {});
          });
        },
        child: const Text('Add User'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: firestoreService.get_all_Users(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          final users = snapshot.data!;
          return list_of_users(users);
        },
      ),
    );
  }

  ListView list_of_users(List<UserModel> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return ListTile(
            title: Text(user.full_name ?? 'No ID'),
            subtitle: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Open edit screen
                    firestoreService
                        .updateUser(UserModel(
                      id: user.id,
                      full_name: 'Massil',
                      photo_url: 'Taswiiira',
                      email: 'user.email',
                      function: '9owaa',
                    ))
                        .then((value) {
                      Get.defaultDialog(
                          textCustom: 'User updated successfully');
                      setState(() {});
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    firestoreService.deleteUser(user.id!).then((value) {
                      Get.defaultDialog(
                          textCustom: 'User deleted successfully');
                      setState(() {});
                    });
                  },
                ),
              ],
            ));
      },
    );
  }
}
