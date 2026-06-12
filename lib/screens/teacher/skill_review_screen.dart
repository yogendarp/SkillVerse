import 'package:flutter/material.dart';

class SkillReviewScreen extends StatelessWidget {
  const SkillReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Skill Review"),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 45,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Yogi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "Student ID : SV2026001",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            _infoCard("Current Skill", "Chess ♟"),
            _infoCard("Current Level", "Level 5"),
            _infoCard("XP Earned", "750 XP"),
            _infoCard("Attendance", "95%"),
            _infoCard("Time in Skill", "4 Months"),
            _infoCard("Performance", "Excellent"),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Teacher Recommendation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Student has successfully completed Level 5 milestones and is eligible for skill advancement.",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Student promoted to next level"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_upward),
                label: const Text("Promote Level"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mentor recommendation submitted"),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                icon: const Icon(Icons.school),
                label: const Text("Recommend as Mentor"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Skill change approved"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle),
                label: const Text("Approve Skill Change"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: ListTile(
        title: Text(title),

        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}