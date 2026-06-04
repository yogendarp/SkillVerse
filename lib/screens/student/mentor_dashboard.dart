import 'package:flutter/material.dart';

class MentorDashboard extends StatelessWidget {
  const MentorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Mentor Dashboard"),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF1E40AF),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "🥇 Gold Mentor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Guiding the next generation of learners",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _statCard(
                    "Mentees",
                    "12",
                    Icons.groups,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    "Rating",
                    "4.8",
                    Icons.star,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                Expanded(
                  child: _statCard(
                    "Requests",
                    "5",
                    Icons.assignment,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    "Community",
                    "AI & ML",
                    Icons.smart_toy,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _actionTile(
              Icons.feedback,
              "Give Feedback",
            ),

            _actionTile(
              Icons.school,
              "Review Student Progress",
            ),

            _actionTile(
              Icons.emoji_events,
              "Recommend Showcase Entry",
            ),

            _actionTile(
              Icons.trending_up,
              "Recommend Level Upgrade",
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 35,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(title),
          ],
        ),
      ),
    );
  }

  static Widget _actionTile(
      IconData icon,
      String title,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}