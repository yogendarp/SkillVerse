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
            "AI & ML",
            "Level 4",
            0.80,
          ),

          _menteeCard(
            "Sneha",
            "Robotics",
            "Level 3",
            0.65,
          ),

          _menteeCard(
            "Arjun",
            "Chess",
            "Level 5",
            0.92,
          ),

          _menteeCard(
            "Priya",
            "Coding",
            "Level 2",
            0.45,
          ),
        ],
      ),
    );
  }

  Widget _menteeCard(
      String name,
      String skill,
      String level,
      double progress,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text("Skill: $skill"),
            Text(level),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
            ),

            const SizedBox(height: 8),

            Text(
              "Progress: ${(progress * 100).toInt()}%",
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,

              children: [

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View Progress",
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Feedback",
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