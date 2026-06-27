import 'package:cloud_firestore/cloud_firestore.dart';

class ShowcaseService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> submitShowcase({
    required String studentId,
    required String studentName,
    required String skillName,
    required int score,
    required String feedback,
  }) async {

    await _firestore.collection("showcases").add({
      "studentId": studentId,
      "studentName": studentName,
      "skillName": skillName,

      "score": score,
      "xp": score, // XP = Score (can change later)

      "feedback": feedback,

      "week": DateTime.now().weekday,
      "month": DateTime.now().month,
      "year": DateTime.now().year,

      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getShowcases() {
    return _firestore
        .collection("showcases")
        .snapshots();
  }

  Stream<QuerySnapshot> getStudentShowcases(String studentId) {
    return _firestore
        .collection("showcases")
        .where(
      "studentId",
      isEqualTo: studentId,
    )
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots();
  }

  Future<int> getTotalXP(String studentId) async {
    final snapshot = await _firestore
        .collection("showcases")
        .where(
      "studentId",
      isEqualTo: studentId,
    )
        .get();

    int totalXP = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      totalXP += (data["xp"] ?? 0) as int;
    }

    return totalXP;
  }
}