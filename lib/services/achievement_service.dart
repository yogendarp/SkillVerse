import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> unlockAchievement({
    required String studentId,
    required String title,
    required String description,
    required String icon,
  }) async {

    final existing = await _firestore
        .collection("achievements")
        .where("studentId", isEqualTo: studentId)
        .where("title", isEqualTo: title)
        .get();

    if (existing.docs.isNotEmpty) {
      return;
    }

    await _firestore.collection("achievements").add({

      "studentId": studentId,

      "title": title,

      "description": description,

      "icon": icon,

      "createdAt": FieldValue.serverTimestamp(),

    });
  }

  Stream<QuerySnapshot> getAchievements(
      String studentId) {

    return _firestore
        .collection("achievements")
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
}