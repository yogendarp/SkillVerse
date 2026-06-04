import 'package:flutter/material.dart';

class StudentFeedbackScreen extends StatefulWidget {
  const StudentFeedbackScreen({super.key});

  @override
  State<StudentFeedbackScreen> createState() =>
      _StudentFeedbackScreenState();
}

class _StudentFeedbackScreenState
    extends State<StudentFeedbackScreen> {

  final TextEditingController strengthsController =
  TextEditingController();

  final TextEditingController improvementController =
  TextEditingController();

  final TextEditingController goalsController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Student Feedback"),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),

                title: Text("Rahul"),

                subtitle: Text(
                  "AI & ML • Level 4",
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Strengths",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: strengthsController,
              maxLines: 4,

              decoration: InputDecoration(
                hintText:
                "Enter student's strengths",

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Areas to Improve",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: improvementController,
              maxLines: 4,

              decoration: InputDecoration(
                hintText:
                "Enter improvement areas",

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Next Goals",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: goalsController,
              maxLines: 4,

              decoration: InputDecoration(
                hintText:
                "Enter next goals",

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content:
                      Text("Feedback Saved"),
                    ),
                  );
                },

                icon: const Icon(Icons.save),

                label: const Text(
                  "Save Feedback",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    strengthsController.dispose();
    improvementController.dispose();
    goalsController.dispose();
    super.dispose();
  }
}