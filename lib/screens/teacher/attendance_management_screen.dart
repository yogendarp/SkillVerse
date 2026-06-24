import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillverse/services/attendance_service.dart';

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

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("role", isEqualTo: "student")
            .snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final students = snapshot.data!.docs;

          if (students.isEmpty) {
            return const Center(
              child: Text("No Students Found"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            itemBuilder: (context, index) {

              final student = students[index];
              final data =
              student.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        data["name"] ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Institution: ${data["institution"]}",
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {

                                await AttendanceService()
                                    .markAttendance(
                                  studentId: student.id,
                                  studentName:
                                  data["name"],
                                  status: "Present",
                                );

                                ScaffoldMessenger.of(
                                    context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${data["name"]} marked Present",
                                    ),
                                    backgroundColor:
                                    Colors.green,
                                  ),
                                );
                              },

                              icon: const Icon(
                                Icons.check,
                              ),

                              label: const Text(
                                "Present",
                              ),

                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.green,
                                foregroundColor:
                                Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {

                                await AttendanceService()
                                    .markAttendance(
                                  studentId: student.id,
                                  studentName:
                                  data["name"],
                                  status: "Absent",
                                );

                                ScaffoldMessenger.of(
                                    context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${data["name"]} marked Absent",
                                    ),
                                    backgroundColor:
                                    Colors.red,
                                  ),
                                );
                              },

                              icon: const Icon(
                                Icons.close,
                              ),

                              label: const Text(
                                "Absent",
                              ),

                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.red,
                                foregroundColor:
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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