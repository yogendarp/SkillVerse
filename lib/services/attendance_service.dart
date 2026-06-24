import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> markAttendance({
    required String studentId,
    required String studentName,
    required String status,
  }) async {

    String today =
    DateTime.now().toString().split(' ')[0];

    // Use studentId + date as document ID
    String attendanceId =
        "${studentId}_$today";

    await _firestore
        .collection("attendance")
        .doc(attendanceId)
        .set({
      "studentId": studentId,
      "studentName": studentName,
      "date": today,
      "status": status,
      "markedAt":
      FieldValue.serverTimestamp(),
    });
  }
  Stream<QuerySnapshot> getStudentAttendance(
      String studentId) {
    return _firestore
        .collection("attendance")
        .where(
      "studentId",
      isEqualTo: studentId,
    )
        .snapshots();
  }

  Future<double> calculateAttendancePercentage(
      String studentId) async {

    QuerySnapshot snapshot =
    await _firestore
        .collection("attendance")
        .where(
      "studentId",
      isEqualTo: studentId,
    )
        .get();

    int total =
        snapshot.docs.length;

    if (total == 0) {
      return 0;
    }

    int presentCount = snapshot.docs
        .where(
          (doc) =>
      doc["status"] == "Present",
    )
        .length;

    return
      (presentCount / total) * 100;
  }
  Future<Map<String, dynamic>> getAttendanceStats(
      String studentId) async {

    QuerySnapshot snapshot =
    await _firestore
        .collection("attendance")
        .where(
      "studentId",
      isEqualTo: studentId,
    )
        .get();

    int total = snapshot.docs.length;

    int present = snapshot.docs
        .where(
          (doc) =>
      doc["status"] == "Present",
    )
        .length;

    int absent = total - present;

    double percentage =
    total == 0
        ? 0
        : (present / total) * 100;

    return {
      "total": total,
      "present": present,
      "absent": absent,
      "percentage": percentage,
    };
  }
}