import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getLeaderboard() {
    return _firestore.collection("showcases").snapshots().asyncMap((_) async {
      QuerySnapshot users = await _firestore.collection("users").get();

      List<Map<String, dynamic>> leaderboard = [];

      for (var user in users.docs) {
        final userData = user.data() as Map<String, dynamic>;

        if (userData["role"] != "student") continue;

        String userId = user.id;
        String name = userData["name"] ?? "Student";

        // Attendance
        QuerySnapshot attendance = await _firestore
            .collection("attendance")
            .where("studentId", isEqualTo: userId)
            .get();

        int totalAttendance = attendance.docs.length;
        int presentAttendance = attendance.docs
            .where((doc) => doc["status"] == "Present")
            .length;

        double attendancePercentage = totalAttendance == 0
            ? 0
            : (presentAttendance / totalAttendance) * 100;

        // XP
        QuerySnapshot showcases = await _firestore
            .collection("showcases")
            .where("studentId", isEqualTo: userId)
            .get();

        int totalXP = 0;

        for (var showcase in showcases.docs) {
          final data = showcase.data() as Map<String, dynamic>;
          totalXP += (data["xp"] ?? 0) as int;
        }

        leaderboard.add({
          "name": name,
          "attendance": attendancePercentage,
          "score": totalXP,
        });
      }

      leaderboard.sort(
            (a, b) => (b["score"] as int).compareTo(a["score"] as int),
      );

      return leaderboard;
    });
  }
}