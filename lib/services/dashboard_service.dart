import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<int> getStudentCount() async {
    QuerySnapshot snapshot =
    await _firestore
        .collection("users")
        .where("role", isEqualTo: "student")
        .get();

    return snapshot.docs.length;
  }

  Future<int> getPendingSkillsCount() async {
    QuerySnapshot snapshot =
    await _firestore
        .collection("skills")
        .where("status", isEqualTo: "Pending")
        .get();

    return snapshot.docs.length;
  }

  Future<int> getShowcaseCount() async {
    QuerySnapshot snapshot =
    await _firestore
        .collection("showcases")
        .get();

    return snapshot.docs.length;
  }
}