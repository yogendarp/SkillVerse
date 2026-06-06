import 'package:flutter/material.dart';

class AttendanceManagementScreen extends StatelessWidget {
  const AttendanceManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Attendance Management"),
        backgroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _studentAttendanceCard(
            context,
            "Yogi",
            "Chess",
            "95%",
          ),

          _studentAttendanceCard(
            context,
            "Rahul",
            "Coding",
            "91%",
          ),

          _studentAttendanceCard(
            context,
            "Sneha",
            "Art",
            "88%",
          ),

          _studentAttendanceCard(
            context,
            "Arjun",
            "Robotics",
            "97%",
          ),
        ],
      ),
    );
  }

  Widget _studentAttendanceCard(
      BuildContext context,
      String studentName,
      String skill,
      String attendance,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              studentName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text("Skill: $skill"),
            Text("Attendance: $attendance"),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$studentName marked Present"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },

                    icon: const Icon(Icons.check),

                    label: const Text("Present"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$studentName marked Absent"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },

                    icon: const Icon(Icons.close),

                    label: const Text("Absent"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}