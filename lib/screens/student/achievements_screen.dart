import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
      ),

      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,

        children: const [

          AchievementBadge(
            icon: Icons.emoji_events,
            title: "Champion",
            subtitle: "Won a Showcase",
            color: Colors.amber,
          ),

          AchievementBadge(
            icon: Icons.local_fire_department,
            title: "30 Day Streak",
            subtitle: "Consistent Practice",
            color: Colors.orange,
          ),

          AchievementBadge(
            icon: Icons.star,
            title: "Quick Learner",
            subtitle: "Reached Level 5",
            color: Colors.blue,
          ),

          AchievementBadge(
            icon: Icons.workspace_premium,
            title: "Skill Master",
            subtitle: "1000 XP Earned",
            color: Colors.purple,
          ),

          AchievementBadge(
            icon: Icons.people,
            title: "Team Player",
            subtitle: "Mentored Others",
            color: Colors.green,
          ),

          AchievementBadge(
            icon: Icons.school,
            title: "Attendance Hero",
            subtitle: "95% Attendance",
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class AchievementBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const AchievementBadge({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            CircleAvatar(
              radius: 30,
              backgroundColor: color.withValues(alpha: 0.2),

              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}