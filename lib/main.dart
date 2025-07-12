import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/AuthGmail/signIn_service.dart';
import 'firebase_options.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          child: ElevatedButton(
            onPressed: () async {
              try {
                AuthService authService = AuthService();

                var user = await authService.signInWithGoogle();
                print(user);
              } catch (e) {
                // ···
              }
            },
            child: const Text('Initialize Firebase'),
          ),
        ),
      ),
    );
  }
}
