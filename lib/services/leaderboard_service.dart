import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>>
  getLeaderboard() async {

    QuerySnapshot users =
    await _firestore
        .collection("users")
        .get();

    List<Map<String, dynamic>>
    leaderboard = [];

    for (var user in users.docs) {

      String userId = user.id;

      Map<String, dynamic> userData =
      user.data()
      as Map<String, dynamic>;

      if (userData["role"] != "student") {
        continue;
      }

      String name =
          userData["name"] ?? "Student";

      // Approved Skills

      QuerySnapshot skills =
      await _firestore
          .collection("skills")
          .where(
        "userId",
        isEqualTo: userId,
      )
          .where(
        "status",
        isEqualTo: "Approved",
      )
          .get();

      int approvedSkills =
          skills.docs.length;

      // Attendance

      QuerySnapshot attendance =
      await _firestore
          .collection("attendance")
          .where(
        "studentId",
        isEqualTo: userId,
      )
          .get();

      int totalAttendance =
          attendance.docs.length;

      int presentAttendance =
          attendance.docs
              .where(
                (doc) =>
            doc["status"] ==
                "Present",
          )
              .length;

      double attendancePercentage =
      totalAttendance == 0
          ? 0
          : (presentAttendance /
          totalAttendance) *
          100;

      double score =
          (approvedSkills * 10) +
              attendancePercentage;

      leaderboard.add({
        "name": name,
        "score": score,
        "approvedSkills":
        approvedSkills,
        "attendance":
        attendancePercentage,
      });
    }

    leaderboard.sort(
          (a, b) =>
          b["score"]
              .compareTo(a["score"]),
    );

    return leaderboard;
  }
}