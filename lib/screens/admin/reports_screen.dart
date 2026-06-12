import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Reports & Analytics"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "System Analytics",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Performance Insights",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _reportTile(
              Icons.calendar_month,
              "Overall Attendance",
              "93%",
              Colors.green,
            ),

            _reportTile(
              Icons.trending_up,
              "Top Skill Community",
              "Coding",
              Colors.blue,
            ),

            _reportTile(
              Icons.emoji_events,
              "Showcases Conducted",
              "28 Events",
              Colors.orange,
            ),

            _reportTile(
              Icons.people,
              "Active Participants",
              "1,240 Students",
              Colors.purple,
            ),

            const SizedBox(height: 25),

            const Text(
              "Generate Reports",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Attendance Report Exported"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text("Export Attendance Report"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Skill Report Exported"),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text("Export Skill Report"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Showcase Report Exported"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text("Export Showcase Report"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _reportTile(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),

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