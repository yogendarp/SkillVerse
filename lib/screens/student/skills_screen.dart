import 'package:flutter/material.dart';
import 'all_skills_screen.dart';
import 'skill_change_request_screen.dart';
import 'add_skill_screen.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        const Color(0xFF2563EB),

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddSkillScreen(),
            ),
          );
        },

        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Skill",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // CURRENT SKILL

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Current Skill",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "♟ Chess",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Community: Chess Masters",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // LEVEL CARD

            skillCard(
              title: "Skill Level",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Level 4 - Intermediate",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text("1450 XP"),

                  const SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: 0.75,
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 10,
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "75% Progress to Skilled",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // MENTOR DETAILS

            skillCard(
              title: "Mentor",
              child: const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("Rahul Kumar"),
                subtitle: Text("Chess Mentor"),
              ),
            ),

            const SizedBox(height: 15),

            // COMMUNITY

            skillCard(
              title: "Community",
              child: const Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.groups),
                    title: Text("Members"),
                    trailing: Text("42"),
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.calendar_month),
                    title: Text("Attendance"),
                    trailing: Text("95%"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ACHIEVEMENTS

            skillCard(
              title: "Achievements",
              child: const Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.emoji_events),
                    title: Text("First Tournament Win"),
                  ),

                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("15-Day Attendance Streak"),
                  ),

                  ListTile(
                    leading: Icon(Icons.workspace_premium),
                    title: Text("Community Champion"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // LEADERBOARD

            skillCard(
              title: "Leaderboard",
              child: const Column(
                children: [

                  ListTile(
                    leading: Text("🥇"),
                    title: Text("Arjun"),
                    trailing: Text("1800 XP"),
                  ),

                  ListTile(
                    leading: Text("🥈"),
                    title: Text("Kavya"),
                    trailing: Text("1650 XP"),
                  ),

                  ListTile(
                    leading: Text("🥉"),
                    title: Text("Yogi"),
                    trailing: Text("1450 XP"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const SkillChangeRequestScreen(),
                    ),
                  );
                },

                icon: const Icon(Icons.swap_horiz),

                label: const Text(
                  "Request Skill Change",
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const AllSkillsScreen(),
                    ),
                  );
                },

                icon: const Icon(Icons.grid_view),

                label: const Text(
                  "View All Skills",
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(15),
              ),

              child: const Text(
                "Skill Change Policy:\n\nA student must remain in a skill community for a minimum of 4 months before submitting a skill change request.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget skillCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          child,
        ],
      ),
    );
  }
}