import 'package:flutter/material.dart';
import 'login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset(
                'assets/images/logo.png',
                height: 120,
              ),

              const SizedBox(height: 30),

              const Text(
                "SkillVerse",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Select Your Role",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              _roleButton(
                context,
                "Student",
                Icons.school,
                "student",
              ),

              const SizedBox(height: 20),

              _roleButton(
                context,
                "Teacher",
                Icons.person,
                "teacher",
              ),

              const SizedBox(height: 20),

              _roleButton(
                context,
                "Admin",
                Icons.admin_panel_settings,
                "admin",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleButton(
      BuildContext context,
      String title,
      IconData icon,
      String role,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 60,

      child: ElevatedButton.icon(
        icon: Icon(icon),

        label: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
        ),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LoginScreen(
                role: role,
              ),
            ),
          );
        },
      ),
    );
  }
}