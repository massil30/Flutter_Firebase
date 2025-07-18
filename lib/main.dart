import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/AuthGmail/signIn_service.dart';
import 'package:flutter_firebase/Firestore/firestore_view.dart';
import 'package:flutter_firebase/HomeView.dart';
import 'package:flutter_firebase/Storage/Image_services.dart';
import 'package:flutter_firebase/Storage/Storage_View.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  // Ensure that Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) {
    debugPrint('Firebase initialized successfully');
  }).catchError((error) {
    debugPrint('Error initializing Firebase: $error');
  });
  Get.put(ImageServices()); // Make ImageServices accessible globally

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GooglAuth authService = GooglAuth();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          authService.getCurrentUser() != null ? StorageView() : StorageView(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GooglAuth authService = GooglAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  User? user = await authService.signInWithGoogle();
                  print(user!.email);
                  print(user.displayName);
                  print(user.photoURL);

                  Get.off(Homeview());
                } catch (e) {
                  // Handle error
                  print('Error signing in: $e');
                }
              },
              child: const Text('Google Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
