import 'package:firebase_auth/firebase_auth.dart';
import 'database_service.dart';
import 'user_service.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signup({
    required String name,
    required String email,
    required String institution,
    required String educationLevel,
    required String password,
    required String role,
  }) async {
    try {

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await DatabaseService().saveUser(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        institution: institution,
        educationLevel: educationLevel,
        role: role,
      );

      return null;

    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {

    try {

      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? role = await UserService().getUserRole(
        userCredential.user!.uid,
      );

      return role;

    } on FirebaseAuthException catch (e) {

      switch (e.code) {

        case "invalid-email":
          return "ERROR:Please enter a valid email address.";

        case "invalid-credential":
          return "ERROR:Invalid email or password.";

        case "user-not-found":
          return "ERROR:No account found with this email.";

        case "wrong-password":
          return "ERROR:Incorrect password.";

        case "user-disabled":
          return "ERROR:This account has been disabled.";

        case "too-many-requests":
          return "ERROR:Too many login attempts. Try again later.";

        case "network-request-failed":
          return "ERROR:No internet connection.";

        default:
          return "ERROR:${e.message ?? "Login failed."}";
      }

    } catch (e) {
      return "ERROR:Something went wrong. Please try again.";
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}