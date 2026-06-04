import 'package:flutter/material.dart';

class SkillManagementScreen extends StatelessWidget {
  const SkillManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Skill Management"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _skillCard(
            "Chess",
            "120 Students",
            Icons.sports_esports,
            Colors.blue,
          ),

          _skillCard(
            "Coding",
            "200 Students",
            Icons.code,
            Colors.green,
          ),

          _skillCard(
            "AI & ML",
            "85 Students",
            Icons.smart_toy,
            Colors.purple,
          ),

          _skillCard(
            "Robotics",
            "65 Students",
            Icons.precision_manufacturing,
            Colors.orange,
          ),

          _skillCard(
            "Photography",
            "40 Students",
            Icons.camera_alt,
            Colors.red,
          ),

          _skillCard(
            "Public Speaking",
            "55 Students",
            Icons.mic,
            Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _skillCard(
      String skillName,
      String students,
      IconData icon,
      Color color,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),

          child: Icon(
            icon,
            color: color,
          ),
        ),

        title: Text(
          skillName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(students),

        trailing: PopupMenuButton<String>(
          onSelected: (value) {},

          itemBuilder: (context) => const [

            PopupMenuItem(
              value: "edit",
              child: Text("Edit Skill"),
            ),

            PopupMenuItem(
              value: "students",
              child: Text("View Students"),
            ),

            PopupMenuItem(
              value: "disable",
              child: Text("Disable Skill"),
            ),
          ],
        ),
      ),
    );
  }
}