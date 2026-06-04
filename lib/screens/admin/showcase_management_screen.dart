import 'package:flutter/material.dart';

class ShowcaseManagementScreen extends StatelessWidget {
  const ShowcaseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Showcase Management"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _showcaseCard(
            "Robotics Expo 2026",
            "120 Participants",
            "Upcoming",
            Colors.blue,
          ),

          _showcaseCard(
            "Coding Hackathon",
            "180 Participants",
            "Upcoming",
            Colors.green,
          ),

          _showcaseCard(
            "Chess Championship",
            "75 Participants",
            "Completed",
            Colors.orange,
          ),

          _showcaseCard(
            "Photography Contest",
            "50 Participants",
            "Completed",
            Colors.purple,
          ),

          _showcaseCard(
            "Public Speaking Event",
            "90 Participants",
            "Upcoming",
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _showcaseCard(
      String title,
      String participants,
      String status,
      Color color,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(
            Icons.emoji_events,
            color: color,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(participants),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: TextStyle(
                color: status == "Upcoming"
                    ? Colors.green
                    : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}