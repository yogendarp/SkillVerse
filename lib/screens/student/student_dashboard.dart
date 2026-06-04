import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'skills_screen.dart';
import 'attendance_screen.dart';
import 'profile_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    SkillsScreen(),
    AttendanceScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: "Skills",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Attendance",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}