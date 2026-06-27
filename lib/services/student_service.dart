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
  Future<List<Map<String, dynamic>>> getStudentsList() async {
    final snapshot = await _firestore
        .collection("users")
        .where("role", isEqualTo: "student")
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return {
        "id": doc.id,
        "name": data["name"] ?? "",
      };
    }).toList();
  }
}