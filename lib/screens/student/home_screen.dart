import 'package:flutter/material.dart';
import 'leaderboard_screen.dart';
import 'showcase_screen.dart';
import 'notifications_screen.dart';
import 'achievements_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/user_service.dart';
import '../../services/attendance_service.dart';
import '../../services/skill_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              FutureBuilder<Map<String, dynamic>?>(
                future: UserService().getUserData(
                  FirebaseAuth.instance.currentUser!.uid,
                ),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Text(
                      "Good Morning",
                    );
                  }

                  return Text(
                    "Good Morning ${snapshot.data!["name"]}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),

              const SizedBox(height: 5),

              const Text(
                "Keep building your skills today!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // XP CARD

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Current Level",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Level 5",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "750 XP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,

                children: [

                  _actionCard(
                    context,
                    "Leaderboard",
                    Icons.leaderboard,
                  ),

                  _actionCard(
                    context,
                    "Showcase",
                    Icons.emoji_events,
                  ),

                  _actionCard(
                    context,
                    "Notifications",
                    Icons.notifications,
                  ),

                  _actionCard(
                    context,
                    "Achievements",
                    Icons.military_tech,
                  ),
                ],
              ),



              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: AttendanceService().getAttendanceStats(
                        FirebaseAuth.instance.currentUser!.uid,
                      ),
                      builder: (context, snapshot) {

                        String attendance = "0%";

                        if (snapshot.hasData) {
                          attendance =
                          "${snapshot.data!['percentage'].toStringAsFixed(1)}%";
                        }

                        return Container(
                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Column(
                            children: [

                              const Icon(
                                Icons.calendar_month,
                                size: 40,
                                color: Colors.green,
                              ),

                              const SizedBox(height: 10),

                              Text(
                                attendance,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const Text("Attendance"),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: FutureBuilder<QuerySnapshot>(
                      future: SkillService().getLatestSkill(
                        FirebaseAuth.instance.currentUser!.uid,
                      ),
                      builder: (context, snapshot) {

                        String skillName = "No Skill";

                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {

                          final skill =
                          snapshot.data!.docs.last.data()
                          as Map<String, dynamic>;

                          skillName =
                              skill['skillName'] ?? "No Skill";
                        }

                        return Container(
                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Column(
                            children: [

                              const Icon(
                                Icons.workspace_premium,
                                size: 40,
                                color: Colors.orange,
                              ),

                              const SizedBox(height: 10),

                              Text(
                                skillName,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const Text("Current Skill"),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Next Showcase",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Saturday Skill Showcase",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "3 Days Remaining",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Recent Achievements",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              achievementTile(
                Icons.emoji_events,
                "Chess Level Up",
                "Reached Intermediate Level",
              ),

              achievementTile(
                Icons.star,
                "Attendance Streak",
                "15 Consecutive Days",
              ),

              achievementTile(
                Icons.military_tech,
                "Top Performer",
                "Weekly Skill Challenge",
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _actionCard(
      BuildContext context,
      String title,
      IconData icon,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),

        onTap: () {

          if (title == "Leaderboard") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LeaderboardScreen(),
              ),
            );
          }

          else if (title == "Showcase") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ShowcaseScreen(),
              ),
            );
          }

          else if (title == "Notifications") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationsScreen(),
              ),
            );
          }

          else if (title == "Achievements") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AchievementsScreen(),
              ),
            );
          }
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 35,
              color: const Color(0xFF2563EB),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget achievementTile(
      IconData icon,
      String title,
      String subtitle,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}