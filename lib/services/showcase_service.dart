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

    await _firestore
        .collection("showcases")
        .add({

      "studentId": studentId,
      "studentName": studentName,
      "skillName": skillName,
      "score": score,
      "feedback": feedback,
      "createdAt":
      FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getShowcases() {
    return _firestore
        .collection("showcases")
        .snapshots();
  }
}