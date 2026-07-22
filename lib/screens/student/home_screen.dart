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
import '../../services/notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  IconData _getNotificationIcon(String title) {

    if (title.contains("Approved")) {
      return Icons.check_circle;
    }

    if (title.contains("Rejected")) {
      return Icons.cancel;
    }

    if (title.contains("Achievement")) {
      return Icons.emoji_events;
    }

    if (title.contains("Attendance")) {
      return Icons.calendar_month;
    }

    if (title.contains("Showcase")) {
      return Icons.star;
    }

    return Icons.notifications;
  }

  Color _getNotificationColor(String title) {

    if (title.contains("Approved")) {
      return Colors.green;
    }

    if (title.contains("Rejected")) {
      return Colors.red;
    }

    if (title.contains("Achievement")) {
      return Colors.orange;
    }

    if (title.contains("Attendance")) {
      return Colors.indigo;
    }

    if (title.contains("Showcase")) {
      return Colors.purple;
    }

    return Colors.blue;
  }

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

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: FutureBuilder<Map<String, dynamic>?>(
                      future: UserService().getUserData(
                        FirebaseAuth.instance.currentUser!.uid,
                      ),
                      builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }

                        final hour = DateTime.now().hour;

                        String greeting;

                        if (hour < 12) {
                          greeting = "Good Morning";
                        } else if (hour < 17) {
                          greeting = "Good Afternoon";
                        } else if (hour < 21) {
                          greeting = "Good Evening";
                        } else {
                          greeting = "Good Night";
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "$greeting, ${snapshot.data!["name"]} 👋",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "Keep building your future 🚀",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("notifications")
                        .where(
                      "userId",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                        .where(
                      "isRead",
                      isEqualTo: false,
                    )
                        .snapshots(),
                    builder: (context, snapshot) {

                      final unread =
                      snapshot.hasData ? snapshot.data!.docs.length : 0;

                      return Stack(
                        children: [

                          IconButton(
                            icon: const Icon(
                              Icons.notifications_outlined,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NotificationsScreen(),
                                ),
                              );
                            },
                          ),

                          if (unread > 0)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  unread > 99 ? "99+" : unread.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // XP CARD

              FutureBuilder<Map<String, dynamic>?>(
                future: UserService().getUserData(
                  FirebaseAuth.instance.currentUser!.uid,
                ),

                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }

                  final user = snapshot.data!;

                  final int xp = user["xp"] ?? 0;
                  final int level = user["level"] ?? 1;

                  final int currentLevelXP = (level - 1) * 200;
                  final int nextLevelXP = level * 200;

                  final double progress =
                  ((xp - currentLevelXP) /
                      (nextLevelXP - currentLevelXP))
                      .clamp(0.0, 1.0);

                  return Container(

                    width: double.infinity,

                    margin: const EdgeInsets.only(bottom: 25),

                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(22),

                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff4F46E5),
                          Color(0xff7C3AED),
                        ],
                      ),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0,6),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Row(

                          children: [

                            const Icon(
                              Icons.workspace_premium,
                              color: Colors.amber,
                              size: 34,
                            ),

                            const SizedBox(width: 10),

                            Text(
                              "Level $level",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        Text(
                          "$xp XP",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 12),

                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(20),

                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor:
                            Colors.white24,
                            valueColor:
                            const AlwaysStoppedAnimation(
                              Colors.amber,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "${nextLevelXP - xp} XP to Level ${level + 1}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
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

                      child: Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LeaderboardScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("View All"),
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
                          ],
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

                      child: Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ShowcaseHistoryScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("View All"),
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
                          ],
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const AchievementsScreen(),
                                    ),
                                  );
                                },
                                child: const Text("View All"),
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