import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GooglAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn.instance; // Preferred way to get instance

  bool _isGoogleSignInInitialized = false; // Track initialization state

  GooglAuth() {
    // It's good practice to ensure initialization, but be careful with async in constructors.
    // Consider calling _initializeGoogleSignIn() explicitly at app startup or before first sign-in.
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    if (!_isGoogleSignInInitialized) {
      try {
        await _googleSignIn.initialize(
            // Add clientId and serverClientId if you're targeting web
            // Example (replace with your actual client IDs):
            // clientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
            // serverClientId: 'YOUR_SERVER_CLIENT_ID.apps.googleusercontent.com',
            );
        _isGoogleSignInInitialized = true;
        print('GoogleSignIn initialized successfully.');
      } catch (e) {
        print('Error initializing GoogleSignIn: $e');
        // Handle this error appropriately in your app (e.g., show a message)
      }
    }
  }

  Future<User?> signInWithGoogle() async {
    await _initializeGoogleSignIn(); // Ensure initialized before attempting sign-in

    try {
      // Use authenticate() for explicit user sign-in
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.authenticate();

      if (googleUser == null) {
        // User cancelled the sign-in flow (authenticate() throws, so this might be rare if you catch the exception)
        return null;
      }

      // authentication is now synchronous
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print(credential);
      return userCredential.user;
    } on GoogleSignInException catch (e) {
      // Handle Google Sign-In specific exceptions
      print(
          'Google Sign-In failed: code: ${e.code}, description: ${e.description}');
      // e.g., if (e.code == GoogleSignInExceptionCode.canceled) ...
      return null;
    } catch (e) {
      print('Unexpected error during Google Sign-In: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOutGoogle() async {
    await _initializeGoogleSignIn(); // Ensure initialized before attempting sign-out
    await _googleSignIn.signOut();
    await _auth.signOut();
    print('User signed out from Google and Firebase.');
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
