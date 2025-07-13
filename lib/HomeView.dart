import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/AuthGmail/signIn_service.dart';
import 'package:flutter_firebase/main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                GooglAuth authService = GooglAuth();
                User? user = authService.getCurrentUser();
                if (user != null) {
                  print(user.email);
                  print(user.displayName);
                  print(user.photoURL);
                } else {
                  print('No user is currently signed in.');
                }
              },
              child: const Text('Current User'),
            ),
            ElevatedButton(
              onPressed: () async {
                GooglAuth authService = GooglAuth();

                authService.signOutGoogle();
                if (authService.getCurrentUser() != null) {
                  print(authService.getCurrentUser()!.email);
                  print(authService.getCurrentUser()!.displayName);
                  print(authService.getCurrentUser()!.photoURL);
                  Get.snackbar(
                    'Sign Out',
                    'User signed out successfully.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  Get.off(MainPage());
                } else {
                  print('No user is currently signed in.');
                }
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
