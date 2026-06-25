import 'package:flutter/material.dart';
import 'skill_review_screen.dart';
import 'teacher_dashboard.dart';
import 'attendance_management_screen.dart';
import 'showcase_management_screen.dart';
import 'teacher_profile_screen.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const TeacherDashboard(),
    const AttendanceManagementScreen(),
    const SkillReviewScreen(),
    const ShowcaseManagementScreen(),
    const TeacherProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        labelBehavior:
          NavigationDestinationLabelBehavior.onlyShowSelected,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: "Attendance",
          ),

          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: "Review",
          ),

          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: "Showcase",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}