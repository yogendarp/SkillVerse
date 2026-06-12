import 'package:flutter/material.dart';
import '../auth/role_selection_screen.dart';
import '../../services/auth_service.dart';
import '../auth/auth_wrapper.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Admin Profile"),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 55,
              child: Icon(
                Icons.admin_panel_settings,
                size: 55,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "System Administrator",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "Admin ID : AD2026001",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Text(
                "Full System Access 🔐",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            _infoCard(
              "Managed Students",
              "520",
            ),

            _infoCard(
              "Managed Teachers",
              "35",
            ),

            _infoCard(
              "Managed Mentors",
              "48",
            ),

            _infoCard(
              "Available Skills",
              "18",
            ),

            _infoCard(
              "System Attendance",
              "93%",
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Admin Responsibilities",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text("• Manage Users"),
                    const Text("• Manage Skills"),
                    const Text("• Manage Showcases"),
                    const Text("• View Reports"),
                    const Text("• System Monitoring"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),

                label: const Text("Edit Profile"),

                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Edit Profile Coming Soon",
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                icon: const Icon(Icons.settings),

                label: const Text("Settings"),

                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Settings Coming Soon",
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),

                label: const Text("Logout"),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),

                onPressed: () async {

                  await AuthService().logout();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AuthWrapper(),
                    ),
                        (route) => false,
                  );
                },
              ),
            ),
            const Text(
              "SkillVerse v1.0",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard(
      String title,
      String value,
      ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),

      child: ListTile(
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