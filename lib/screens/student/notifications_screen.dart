import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),

      body: ListView(
        children: const [

          NotificationTile(
            icon: Icons.emoji_events,
            color: Colors.amber,
            title: "Achievement Unlocked",
            subtitle: "You earned the Quick Learner badge.",
            time: "2 mins ago",
          ),

          NotificationTile(
            icon: Icons.school,
            color: Colors.blue,
            title: "Mentor Update",
            subtitle: "Your mentor approved your progress report.",
            time: "1 hour ago",
          ),

          NotificationTile(
            icon: Icons.campaign,
            color: Colors.orange,
            title: "Showcase Event",
            subtitle: "Saturday Skill Showcase starts in 3 days.",
            time: "Today",
          ),

          NotificationTile(
            icon: Icons.calendar_month,
            color: Colors.green,
            title: "Attendance Updated",
            subtitle: "Your attendance is now 95%.",
            time: "Yesterday",
          ),

          NotificationTile(
            icon: Icons.workspace_premium,
            color: Colors.purple,
            title: "XP Earned",
            subtitle: "You gained 50 XP from Chess Practice.",
            time: "Yesterday",
          ),

          NotificationTile(
            icon: Icons.info,
            color: Colors.teal,
            title: "System Notice",
            subtitle: "SkillVerse v1.0 demo build is active.",
            time: "2 days ago",
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}