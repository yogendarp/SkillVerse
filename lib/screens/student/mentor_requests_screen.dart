import 'package:flutter/material.dart';

class MentorRequestsScreen extends StatelessWidget {
  const MentorRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mentor Requests"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _requestCard(
            "Rahul",
            "Requested mentorship for AI & ML",
          ),

          _requestCard(
            "Sneha",
            "Needs guidance in Robotics",
          ),

          _requestCard(
            "Arjun",
            "Requested project review",
          ),

          _requestCard(
            "Priya",
            "Seeking career guidance",
          ),
        ],
      ),
    );
  }

  Widget _requestCard(
      String student,
      String request,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              student,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(request),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,

              children: [

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text("Approve"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                  label: const Text("Reject"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
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