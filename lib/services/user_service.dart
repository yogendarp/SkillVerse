import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  Future<String?> getUserRole(String uid) async {

    try {

      DocumentSnapshot doc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        return doc['role'];
      }

      return null;

    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<Map<String, dynamic>?> getUserData(
      String uid,
      ) async {

    DocumentSnapshot doc =
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if(doc.exists){
      return doc.data()
      as Map<String, dynamic>;
    }

    return null;
  }
}