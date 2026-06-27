import 'package:cloud_firestore/cloud_firestore.dart';

class SkillService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSkill({
    required String userId,
    required String skillName,
    required String description,
    required String level,
  }) async {
    DocumentSnapshot userDoc =
    await _firestore.collection('users').doc(userId).get();

    final userData =
    userDoc.data() as Map<String, dynamic>;

    String studentName = userData['name'];

    await _firestore.collection('skills').add({
    'userId': userId,
    'studentName': studentName,
    'skillName': skillName,
    'description': description,
    'level': level,
    'status': 'Pending',
    'createdAt': FieldValue.serverTimestamp(),
    });

  }

  Future<void> updateSkill({
    required String skillId,
    required String skillName,
    required String description,
    required String level,
  }) async {
    await _firestore.collection('skills').doc(skillId).update({
      'skillName': skillName,
      'description': description,
      'level': level,
    });
  }

  Future<void> deleteSkill(String skillId) async {
    await _firestore.collection('skills').doc(skillId).delete();
  }

  Stream<QuerySnapshot> getUserSkills(String userId) {
    return _firestore
        .collection('skills')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<QuerySnapshot> getLatestSkill(String userId) {
    return _firestore
        .collection('skills')
        .where('userId', isEqualTo: userId)
        .get();
  }
  Future<Map<String, dynamic>?> getApprovedSkill(
      String userId) async {

    final snapshot = await _firestore
        .collection("skills")
        .where("userId", isEqualTo: userId)
        .where("status", isEqualTo: "Approved")
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.data()
    as Map<String, dynamic>;
  }
}
