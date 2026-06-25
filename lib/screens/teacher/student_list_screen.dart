import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/student_service.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: StudentService().getStudents(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Students Found"),
            );
          }

          final students = snapshot.data!.docs;

          return ListView.builder(
            itemCount: students.length,

            itemBuilder: (context, index) {

              final data =
              students[index].data()
              as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),

                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),

                  title: Text(
                    data["name"] ?? "Unknown",
                  ),

                  subtitle: Text(
                    data["institution"] ?? "",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}