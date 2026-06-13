import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> saveUser({
    required String uid,
    required String name,
    required String email,
    required String institution,
    required String educationLevel,
    required String role,
  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .set({

      "name": name,
      "email": email,
      "institution": institution,
      "educationLevel": educationLevel,
      "role": role,
      "createdAt": FieldValue.serverTimestamp(),

    });
  }
  Future<void> updateUser({
    required String uid,
    required String name,
    required String institution,
    required String educationLevel,
  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .update({

      "name": name,
      "institution": institution,
      "educationLevel": educationLevel,

    });
  }
}