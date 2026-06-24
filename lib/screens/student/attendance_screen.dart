import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/attendance_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() =>
      _AttendanceScreenState();
}

class _AttendanceScreenState
    extends State<AttendanceScreen> {

  double attendancePercentage = 0;
  int presentCount = 0;
  int absentCount = 0;

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  Future<void> loadAttendance() async {

    String studentId =
        FirebaseAuth.instance.currentUser!.uid;

    final stats =
    await AttendanceService()
        .getAttendanceStats(studentId);

    if (!mounted) return;

    setState(() {
      attendancePercentage =
      stats["percentage"];

      presentCount =
      stats["present"];

      absentCount =
      stats["absent"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Attendance",
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // SUMMARY CARD

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    "Overall Attendance",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "${attendancePercentage.toStringAsFixed(1)}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "June 2026",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 2,

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [

                    _buildWeek(
                        ["P","P","P","P","A","P","P"]),

                    const SizedBox(height: 10),

                    _buildWeek(
                        ["P","P","P","P","P","P","P"]),

                    const SizedBox(height: 10),

                    _buildWeek(
                        ["P","P","P","A","P","P","P"]),

                    const SizedBox(height: 10),

                    _buildWeek(
                        ["P","P","P","P","P","P","P"]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _statCard(
                    "Present",
                    presentCount.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    "Absent",
                    absentCount.toString(),
                    Icons.cancel,
                    Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Attendance Remarks",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Excellent attendance record. Keep maintaining consistency in your skill community activities.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildWeek(List<String> week) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,

      children: week.map((day) {

        return CircleAvatar(
          radius: 18,

          backgroundColor:
          day == "P"
              ? Colors.green
              : Colors.red,

          child: Text(
            day,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  static Widget _statCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 35,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(title),
          ],
        ),
      ),
    );
  }
}