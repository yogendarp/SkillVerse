import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  String selectedRole = "student";
  String selectedEducationLevel = "School";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final institutionController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    institutionController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: institutionController,
              decoration: const InputDecoration(
                labelText: "Institution Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedEducationLevel,

              decoration: const InputDecoration(
                labelText: "Education Level",
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: "School",
                  child: Text("School"),
                ),
                DropdownMenuItem(
                  value: "College",
                  child: Text("College"),
                ),
                DropdownMenuItem(
                  value: "University",
                  child: Text("University"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  selectedEducationLevel = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            DropdownButtonFormField<String>(
              value: selectedRole,

              decoration: const InputDecoration(
                labelText: "Role",
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: "student",
                  child: Text("Student"),
                ),
                DropdownMenuItem(
                  value: "teacher",
                  child: Text("Teacher"),
                ),
                DropdownMenuItem(
                  value: "admin",
                  child: Text("Admin"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            ElevatedButton(

              onPressed: () async {

                if(nameController.text.trim().isEmpty ||
                    institutionController.text.trim().isEmpty) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                    ),
                  );

                  return;
                }

                if(passwordController.text !=
                    confirmPasswordController.text) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Passwords do not match"),
                    ),
                  );

                  return;
                }

                setState(() {
                  loading = true;
                });

                String? result =
                await AuthService().signup(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  institution: institutionController.text.trim(),
                  educationLevel: selectedEducationLevel,
                  password: passwordController.text.trim(),
                  role: selectedRole,
                );

                setState(() {
                  loading = false;
                });

                if(result == null) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account Created Successfully"),
                    ),
                  );

                  Navigator.pop(context);

                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                }
              },

              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Sign Up"),
            ),
          ],
        ),
        ),
      ),
    );
  }
}