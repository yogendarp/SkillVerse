import 'package:flutter/material.dart';

class StudentFeedbackScreen extends StatelessWidget {
  const StudentFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Feedback"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _feedbackCard(
            "Rahul",
            "Excellent progress in AI & ML. Keep working on model optimization and project building.",
            "2 days ago",
          ),

          _feedbackCard(
            "Sneha",
            "Good improvement in Robotics. Focus more on sensor integration and testing.",
            "1 week ago",
          ),

          _feedbackCard(
            "Arjun",
            "Outstanding consistency in Chess. Continue participating in showcases.",
            "2 weeks ago",
          ),

          _feedbackCard(
            "Priya",
            "Strong learning attitude. Improve coding practice frequency.",
            "3 weeks ago",
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Add Feedback feature coming soon"),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _feedbackCard(
      String student,
      String feedback,
      String date,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: Padding(
        padding: const EdgeInsets.all(16),

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

                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(feedback),
          ],
        ),
      ),
    );
  }
}