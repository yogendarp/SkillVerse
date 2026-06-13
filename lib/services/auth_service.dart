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

      String? role =
      await UserService().getUserRole(
        userCredential.user!.uid,
      );

      return role;

    } on FirebaseAuthException catch (e) {

      return "ERROR:${e.message}";
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}