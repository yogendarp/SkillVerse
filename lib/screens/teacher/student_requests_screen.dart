import 'package:flutter/material.dart';

class StudentRequestsScreen extends StatelessWidget {
  const StudentRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Skill Change Requests"),
        backgroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _requestCard(
            studentName: "Yogi",
            currentSkill: "Chess",
            requestedSkill: "Robotics",
            level: "Level 5",
            duration: "4 Months",
            reason:
            "I have completed my Chess learning path and want to move towards Robotics.",
          ),

          _requestCard(
            studentName: "Rahul",
            currentSkill: "Coding",
            requestedSkill: "AI & ML",
            level: "Level 4",
            duration: "6 Months",
            reason:
            "Interested in Artificial Intelligence and completed all coding milestones.",
          ),

          _requestCard(
            studentName: "Sneha",
            currentSkill: "Art",
            requestedSkill: "Photography",
            level: "Level 3",
            duration: "5 Months",
            reason:
            "Want to explore creative media and visual storytelling.",
          ),
        ],
      ),
    );
  }

  Widget _requestCard({
    required String studentName,
    required String currentSkill,
    required String requestedSkill,
    required String level,
    required String duration,
    required String reason,
  }) {
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

            const SizedBox(height: 12),

            Text("Current Skill: $currentSkill"),
            Text("Requested Skill: $requestedSkill"),
            Text("Current Level: $level"),
            Text("Time in Skill: $duration"),

            const SizedBox(height: 12),

            const Text(
              "Reason",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(reason),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // approve logic later
                    },

                    icon: const Icon(Icons.check),

                    label: const Text("Approve"),

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
                      // reject logic later
                    },

                    icon: const Icon(Icons.close),

                    label: const Text("Reject"),

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