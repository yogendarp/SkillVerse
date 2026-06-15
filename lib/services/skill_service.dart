import 'package:cloud_firestore/cloud_firestore.dart';

class SkillService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addSkill({
    required String userId,
    required String skillName,
    required String description,
    required String level,
  }) async {

    await _firestore
        .collection("skills")
        .add({

      "userId": userId,
      "skillName": skillName,
      "description": description,
      "level": level,
      "status": "Pending",
      "createdAt": FieldValue.serverTimestamp(),

    });
  }
}