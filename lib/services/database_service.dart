import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> saveUser({
    required String uid,
    required String email,
    required String role,
  }) async {

    try {

      print("Saving user...");

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({
        "email": email,
        "role": role,
        "createdAt": Timestamp.now(),
      });

      print("Saved successfully");

    } catch (e) {

      print("Firestore Error: $e");

      rethrow;
    }
  }
}