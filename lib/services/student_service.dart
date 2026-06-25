import 'package:cloud_firestore/cloud_firestore.dart';

class StudentService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<QuerySnapshot> getStudents() {

    return _firestore
        .collection("users")
        .where(
      "role",
      isEqualTo: "student",
    )
        .snapshots();
  }
}