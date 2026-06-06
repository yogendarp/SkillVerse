import 'package:flutter/material.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final students = [
      {"name": "Yogi", "skill": "Chess", "attendance": "95%"},
      {"name": "Rahul", "skill": "Coding", "attendance": "88%"},
      {"name": "Sneha", "skill": "Art", "attendance": "92%"},
      {"name": "Priya", "skill": "Robotics", "attendance": "90%"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(student["name"]!),
              subtitle: Text(
                "${student["skill"]} • Attendance ${student["attendance"]}",
              ),
            ),
          );
        },
      ),
    );
  }
}