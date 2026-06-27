import 'package:flutter/material.dart';
import '../../services/showcase_service.dart';
import '../../services/student_service.dart';
import '../../services/skill_service.dart';
import '../../services/notification_service.dart';

class ShowcaseManagementScreen extends StatefulWidget {
  const ShowcaseManagementScreen({super.key});

  @override
  State<ShowcaseManagementScreen> createState() =>
      _ShowcaseManagementScreenState();
}

class _ShowcaseManagementScreenState
    extends State<ShowcaseManagementScreen> {

  final StudentService studentService = StudentService();
  final SkillService skillService = SkillService();
  final ShowcaseService showcaseService = ShowcaseService();

  List<Map<String, dynamic>> students = [];

  String? selectedStudentId;
  String? selectedStudentName;
  String? selectedSkill;

  final scoreController = TextEditingController();
  final feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {

    students = await studentService.getStudentsList();

    if (!mounted) return;

    setState(() {});
  }

  Future<void> loadSkill(String studentId) async {

    final skill =
    await skillService.getApprovedSkill(studentId);

    if (skill == null) {

      selectedSkill = null;

    } else {

      selectedSkill = skill["skillName"];
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Showcase Management"),
        backgroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Create Showcase feature coming soon"),
            ),
          );
        },

        child: const Icon(Icons.add),
      ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

            const Text(
            "Weekly Showcase Evaluation",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          DropdownButtonFormField<String>(

            value: selectedStudentId,

            decoration: const InputDecoration(
              labelText: "Select Student",
              border: OutlineInputBorder(),
            ),

            items: students.map((student) {

              return DropdownMenuItem<String>(

                value: student["id"] as String,

                child: Text(student["name"] as String),

              );

            }).toList(),

            onChanged: (value) async {

              selectedStudentId = value;

              selectedStudentName = students
                  .firstWhere(
                      (e) => e["id"] == value)["name"];

              await loadSkill(value!);
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Current Skill",
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),

          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
              BorderRadius.circular(12),
            ),

            child: Text(
              selectedSkill ?? "No Approved Skill",
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: scoreController,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: "Score",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: feedbackController,
            maxLines: 3,

            decoration: const InputDecoration(
              labelText: "Teacher Feedback",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                ),

                onPressed: () async {

                  if (selectedStudentId == null ||
                      selectedSkill == null ||
                      scoreController.text.isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please complete all fields"),
                      ),
                    );
                    return;
                  }

                  await ShowcaseService().submitShowcase(
                    studentId: selectedStudentId!,
                    studentName: selectedStudentName!,
                    skillName: selectedSkill!,
                    score: int.parse(scoreController.text),
                    feedback: feedbackController.text,
                  );

                  await NotificationService().createNotification(
                    userId: selectedStudentId!,
                    title: "Weekly Showcase Result",
                    message:
                    "You scored ${scoreController.text} in $selectedSkill.\nTeacher Feedback: ${feedbackController.text}",
                  );

                  scoreController.clear();
                  feedbackController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Showcase submitted successfully"),
                    ),
                  );
                },

                child: const Text(
                  "Submit Showcase",
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
          ),
        ),
    );
  }

  Widget _showcaseCard(
  BuildContext context, {
    required String title,
    required String date,
    required String venue,
    required String participants,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),

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

            Text("📅 Date : $date"),
            Text("📍 Venue : $venue"),
            Text("👥 Participants : $participants"),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Viewing $title"),
                        ),
                      );
                    },
                    child: const Text("View"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Editing $title"),
                        ),
                      );
                    },
                    child: const Text("Edit"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _completedShowcase(
      String title,
      String status,
      ) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.emoji_events,
          color: Colors.orange,
        ),
        title: Text(title),
        subtitle: Text(status),
      ),
    );
  }
}