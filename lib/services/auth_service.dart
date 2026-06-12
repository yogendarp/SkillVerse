import 'package:firebase_auth/firebase_auth.dart';
import 'database_service.dart';
import 'user_service.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signup({
    required String email,
    required String password,
    required String role,
  }) async {

    try {

      print("STEP 1");

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("STEP 2");

      await DatabaseService().saveUser(
        uid: userCredential.user!.uid,
        email: email,
        role: role,
      );

      print("STEP 3");

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