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
import 'showcase_history_screen.dart';
import '../../services/showcase_service.dart';
import '../../services/leaderboard_service.dart';

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

                  final hour = DateTime.now().hour;

                  String greeting;

                  if (hour < 12) {
                    greeting = "Good Morning";
                  }
                  else if (hour < 17) {
                    greeting = "Good Afternoon";
                  }
                  else if (hour < 21) {
                    greeting = "Good Evening";
                  }
                  else {
                    greeting = "Good Night";
                  }

                  return Text(
                    "$greeting ${snapshot.data!["name"]} 👋",
                    style: const TextStyle(
                      fontSize: 26,
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

              FutureBuilder<int>(
                future: ShowcaseService().getTotalXP(
                  FirebaseAuth.instance.currentUser!.uid,
                ),

                builder: (context, snapshot) {

                  final xp = snapshot.data ?? 0;

                  final level = (xp ~/ 100) + 1;

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "⭐ Skill Progress",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Level $level",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "$xp XP Earned",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Keep Growing 🚀",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

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

                              const Text(
                                "Attendance",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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

                              const Text(
                                "Current Skill",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                      "📅 Upcoming Evaluation",
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
                      "Prepare your skill for this week's review.",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              const Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              FutureBuilder<List<Map<String, dynamic>>>(
                future: LeaderboardService().getLeaderboard().first,

                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  final leaders = snapshot.data!;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: InkWell(

                      borderRadius: BorderRadius.circular(18),

                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LeaderboardScreen(),
                          ),
                        );

                      },

                      child: Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            const Row(

                              children: [

                                Icon(
                                  Icons.emoji_events,
                                  color: Colors.orange,
                                ),

                                SizedBox(width: 10),

                                Text(
                                  "Leaderboard",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            for (int i = 0;
                            i < leaders.length && i < 3;
                            i++)

                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),

                                child: Row(

                                  children: [

                                    Text(
                                      i == 0
                                          ? "🥇"
                                          : i == 1
                                          ? "🥈"
                                          : "🥉",
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Text(
                                        leaders[i]["name"],
                                      ),
                                    ),

                                    Text(
                                      "${leaders[i]["score"]} XP",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const Divider(),

                            const Align(
                              alignment: Alignment.centerRight,

                              child: Text(
                                "View Full →",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              StreamBuilder<QuerySnapshot>(

                stream: ShowcaseService()
                    .getStudentShowcases(
                  FirebaseAuth.instance.currentUser!.uid,
                ),

                builder: (context, snapshot) {

                  if (!snapshot.hasData) {

                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );

                  }

                  if (snapshot.data!.docs.isEmpty) {

                    return const Card(
                      child: ListTile(
                        leading: Icon(Icons.history_edu),
                        title: Text("Showcase History"),
                        subtitle: Text(
                          "No showcase evaluations yet",
                        ),
                      ),
                    );

                  }

                  final data = snapshot.data!.docs.first.data()
                  as Map<String, dynamic>;

                  return Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: InkWell(

                      borderRadius: BorderRadius.circular(18),

                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const ShowcaseHistoryScreen(),
                          ),
                        );

                      },

                      child: Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Row(

                              children: [

                                Icon(
                                  Icons.history_edu,
                                  color: Colors.indigo,
                                ),

                                SizedBox(width: 10),

                                Text(
                                  "Showcase History",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),

                            const SizedBox(height: 18),

                            Text(
                              "Latest Evaluation",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              data["skillName"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "Score : ${data["score"]}/100",
                            ),

                            Text(
                              "XP Earned : +${data["xp"]}",
                            ),

                            const SizedBox(height: 10),

                            Text(
                              data["feedback"],
                              maxLines: 2,
                              overflow:
                              TextOverflow.ellipsis,
                            ),

                            const Divider(),

                            const Align(

                              alignment:
                              Alignment.centerRight,

                              child: Text(
                                "View All →",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("skills")
                    .where(
                  "userId",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                    .where(
                  "status",
                  isEqualTo: "Approved",
                )
                    .limit(1)
                    .get(),

                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {

                    return const Card(
                      child: ListTile(
                        leading: Icon(Icons.emoji_events),
                        title: Text("Achievements"),
                        subtitle: Text("Complete your first skill to unlock achievements."),
                      ),
                    );
                  }

                  final data =
                  snapshot.data!.docs.first.data()
                  as Map<String, dynamic>;

                  return Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          const Row(
                            children: [

                              Icon(
                                Icons.emoji_events,
                                color: Colors.orange,
                              ),

                              SizedBox(width: 10),

                              Text(
                                "Achievements",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Text(
                            "🏅 ${data["skillName"]} Master",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Reached Level ${data["level"]}",
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Congratulations on completing another milestone!",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              const Text(
                "🔔 Latest Notification",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("notifications")
                    .where(
                  "userId",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                    .orderBy(
                  "createdAt",
                  descending: true,
                )
                    .limit(1)
                    .snapshots(),

                builder: (context, snapshot) {

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {

                    return const Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_none),
                        title: Text("No notifications"),
                      ),
                    );
                  }

                  final data =
                  snapshot.data!.docs.first.data()
                  as Map<String, dynamic>;

                  return Card(
                  child: InkWell(

                      borderRadius: BorderRadius.circular(12),

                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const NotificationsScreen(),
                          ),
                        );

                      },
                    child: ListTile(

                      leading: const Icon(
                        Icons.notifications,
                        color: Colors.blue,
                      ),

                      title: Text(data["title"]),

                      subtitle: Text(data["message"]),

                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                      ),
                  );
                },
              ),

              const Text(
                "🏅 Recent Achievements",
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

          else if (title == "Showcase History") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                const ShowcaseHistoryScreen(),
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