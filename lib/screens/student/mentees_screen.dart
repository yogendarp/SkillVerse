import 'package:flutter/material.dart';

class MenteesScreen extends StatelessWidget {
  const MenteesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Mentees"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _menteeCard(
            "Rahul",
            "Level 4",
            "92%",
          ),

          _menteeCard(
            "Priya",
            "Level 5",
            "96%",
          ),

          _menteeCard(
            "Arjun",
            "Level 3",
            "88%",
          ),
        ],
      ),
    );
  }

  Widget _menteeCard(
      String name,
      String level,
      String attendance,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),

        title: Text(name),

        subtitle: Text(
          "$level • Attendance $attendance",
        ),

        trailing: PopupMenuButton(
          itemBuilder: (context) => const [

            PopupMenuItem(
              value: "progress",
              child: Text("View Progress"),
            ),

            PopupMenuItem(
              value: "feedback",
              child: Text("Give Feedback"),
            ),

            PopupMenuItem(
              value: "attendance",
              child: Text("View Attendance"),
            ),
          ],
        ),
      ),
    );
  }
}