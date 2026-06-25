import 'package:flutter/material.dart';
import 'attendance_management_screen.dart';
import 'skill_review_screen.dart';
import 'showcase_management_screen.dart';
import 'student_list_screen.dart';
import '../../services/dashboard_service.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() =>
      _TeacherDashboardState();
}

class _TeacherDashboardState
    extends State<TeacherDashboard> {

  int students = 0;
  int pendingSkills = 0;
  int showcases = 0;

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {

    DashboardService service =
    DashboardService();

    students =
    await service.getStudentCount();

    pendingSkills =
    await service.getPendingSkillsCount();

    showcases =
    await service.getShowcaseCount();

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Teacher Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Welcome Teacher 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage students and monitor progress",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _dashboardCard(
                    context,
                    "Students",
                    students.toString(),
                    Icons.people,
                    Colors.blue,
                    const StudentListScreen(),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _dashboardCard(
                    context,
                    "Pending Skills",
                    pendingSkills.toString(),
                    Icons.assignment,
                    Colors.orange,
                    const SkillReviewScreen(),
                  ),
                ),
            ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                Expanded(
                  child: _dashboardCard(
                    context,
                    "Attendance",
                    "92%",
                    Icons.calendar_month,
                    Colors.green,
                    const AttendanceManagementScreen(),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _dashboardCard(
                    context,
                    "Showcases",
                    showcases.toString(),
                    Icons.emoji_events,
                    Colors.purple,
                    const ShowcaseManagementScreen(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Pending Skill Change Requests",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _requestTile(
              context,
              "Yogi",
              "Chess",
              "Robotics",
            ),

            _requestTile(
              context,
              "Rahul",
              "Coding",
              "AI & ML",
            ),

            _requestTile(
              context,
              "Sneha",
              "Art",
              "Photography",
            ),
          ],
        ),
      ),
    );
  }

  static Widget _dashboardCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      Widget screen,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => screen,
          ),
        );
      },

      child: Card(
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _requestTile(
      BuildContext context,
      String student,
      String currentSkill,
      String requestedSkill,
      ) {
    return Card(
      child: ListTile(
        title: Text(student),

        subtitle: Text(
          "$currentSkill → $requestedSkill",
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,

          children: [

            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$student approved"),
                    backgroundColor: Colors.green,
                  ),
                );
              },

              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),

            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$student rejected"),
                    backgroundColor: Colors.red,
                  ),
                );
              },

              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}