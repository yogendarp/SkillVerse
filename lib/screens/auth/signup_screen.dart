import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  String selectedRole = "student";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
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

            ElevatedButton(

              onPressed: () async {

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
                  email: emailController.text.trim(),
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
    );
  }
}