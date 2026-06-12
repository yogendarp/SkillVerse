import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/user_service.dart';

import '../student/student_home.dart';
import '../teacher/teacher_home.dart';
import '../admin/admin_home.dart';
import 'login_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(

      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {

          return FutureBuilder<String?>(

            future: UserService().getUserRole(
              snapshot.data!.uid,
            ),

            builder: (context, roleSnapshot) {

              if (roleSnapshot.connectionState ==
                  ConnectionState.waiting) {

                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              String? role = roleSnapshot.data;

              if (role == "student") {
                return const StudentHome();
              }

              if (role == "teacher") {
                return const TeacherHome();
              }

              if (role == "admin") {
                return const AdminHome();
              }

              if (role == null) {

                FirebaseAuth.instance.signOut();

                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const LoginScreen();
            },
          );
        }
        return const LoginScreen();
      },
    );
  }
}