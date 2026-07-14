import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> unlockAchievement({
    required String userId,
    required String title,
    required String description,
    required String type,
  }) async {

    final existing = await _firestore
        .collection("achievements")
        .where("userId", isEqualTo: userId)
        .where("title", isEqualTo: title)
        .get();

    if (existing.docs.isNotEmpty) {
      return;
    }

    await _firestore.collection("achievements").add({

      "userId": userId,

      "title": title,

      "description": description,

      "type": type,

      "createdAt": FieldValue.serverTimestamp(),

    });
  }

  Stream<QuerySnapshot> getAchievements(
      String userId) {

    return _firestore
        .collection("achievements")
        .where(
      "userId",
      isEqualTo: userId,
    )
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots();
  }
}