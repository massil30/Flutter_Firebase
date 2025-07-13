import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/AuthGmail/signIn_service.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() {
  // Ensure that Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) {
    debugPrint('Firebase initialized successfully');
  }).catchError((error) {
    debugPrint('Error initializing Firebase: $error');
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Firebase Example'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    GooglAuth authService = GooglAuth();

                    User? user = await authService.signInWithGoogle();
                    print(user!.email);
                    print(user.displayName);
                    print(user.photoURL);

                    Get.dialog(
                      AlertDialog(
                        title: Text("Image Preview"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              user.photoURL!,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10),
                            Text("This is an image inside a dialog."),
                          ],
                        ),
                      ),
                    );
                  } catch (e) {
                    // Handle error
                    print('Error signing in: $e');
                  }
                },
                child: const Text('Google Sign In'),
              ),
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
                  } else {
                    print('No user is currently signed in.');
                  }
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
