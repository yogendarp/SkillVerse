import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Admin Dashboard",
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
              "Welcome Admin 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Monitor and manage the SkillVerse ecosystem",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _dashboardCard(
                    "Students",
                    "520",
                    Icons.school,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _dashboardCard(
                    "Teachers",
                    "35",
                    Icons.person,
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                Expanded(
                  child: _dashboardCard(
                    "Mentors",
                    "48",
                    Icons.groups,
                    Colors.orange,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _dashboardCard(
                    "Skills",
                    "18",
                    Icons.workspace_premium,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "System Overview",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _overviewTile(
              Icons.assignment,
              "Pending Skill Requests",
              "12 Requests",
              Colors.orange,
            ),

            _overviewTile(
              Icons.emoji_events,
              "Upcoming Showcases",
              "6 Events",
              Colors.purple,
            ),

            _overviewTile(
              Icons.calendar_month,
              "Overall Attendance",
              "93%",
              Colors.green,
            ),

            const SizedBox(height: 25),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,

              children: [

                _actionCard(
                  Icons.person_add,
                  "Add Student",
                ),

                _actionCard(
                  Icons.badge,
                  "Add Teacher",
                ),

                _actionCard(
                  Icons.groups,
                  "Add Mentor",
                ),

                _actionCard(
                  Icons.workspace_premium,
                  "Add Skill",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _dashboardCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Icon(
              icon,
              size: 35,
              color: color,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(title),
          ],
        ),
      ),
    );
  }

  static Widget _overviewTile(
      IconData icon,
      String title,
      String subtitle,
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
          subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget _actionCard(
      IconData icon,
      String title,
      ) {
    return Card(
      elevation: 2,

      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 35,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}