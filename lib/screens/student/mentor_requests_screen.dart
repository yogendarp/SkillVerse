import 'package:flutter/material.dart';

class MentorRequestsScreen extends StatelessWidget {
  const MentorRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Mentor Requests"),
        backgroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _requestCard(
            "Rahul",
            "Need help with AI Project",
            "High",
          ),

          _requestCard(
            "Priya",
            "Requesting Showcase Guidance",
            "Medium",
          ),

          _requestCard(
            "Arjun",
            "Need help with Python Basics",
            "Low",
          ),

          _requestCard(
            "Sneha",
            "Seeking Career Advice",
            "Medium",
          ),
        ],
      ),
    );
  }

  Widget _requestCard(
      String student,
      String request,
      String priority,
      ) {
    Color priorityColor = Colors.green;

    if (priority == "High") {
      priorityColor = Colors.red;
    } else if (priority == "Medium") {
      priorityColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  student,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Chip(
                  label: Text(priority),
                  backgroundColor:
                  priorityColor.withOpacity(0.15),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(request),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.check),

                    label: const Text("Accept"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.schedule),

                    label: const Text("Schedule"),
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