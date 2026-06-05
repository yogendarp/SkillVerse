import 'package:flutter/material.dart';
import '../teacher/teacher_dashboard.dart';
import '../admin/admin_dashboard.dart';
import '../student/student_home.dart';
import '../teacher/teacher_home.dart';
import '../admin/admin_home.dart';

class LoginScreen extends StatefulWidget {

  final String role;

  const LoginScreen({
    super.key,
    required this.role,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter email"),
        ),
      );
      return;
    }

    final emailRegex =
    RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address"),
        ),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter password"),
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Password must contain at least 6 characters"),
        ),
      );
      return;
    }

    if (widget.role == "student") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const StudentHome(),
        ),
      );
    }
    else if (widget.role == "teacher") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const TeacherHome(),
        ),
      );
    }
    else if (widget.role == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminHome(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Text(
                  "Welcome ${widget.role}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Login as ${widget.role}",
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: login,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}