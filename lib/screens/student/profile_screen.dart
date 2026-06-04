import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Profile",
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Yogi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "Student ID : SV2026001",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),

              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Text(
                "Future Mentor Candidate 🌟",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 25),

            _infoCard(
              "Current Skill",
              "Chess ♟",
            ),

            _infoCard(
              "Current Level",
              "Level 5",
            ),

            _infoCard(
              "XP",
              "750 XP",
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "XP Progress",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 10,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "750 / 1000 XP to reach Level 6",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Skill Change Status",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Eligible after 4 months in current skill",
                    ),

                    SizedBox(height: 5),

                    Text(
                      "2 Months Remaining",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _infoCard(
              "Attendance",
              "95%",
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Achievements",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text("🏆 Quick Learner"),
                    Text("🔥 30 Day Streak"),
                    Text("⭐ Showcase Winner"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Skill Journey",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Chess ♟ → Coding 💻 → Robotics 🤖",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),

                label: const Text("Logout"),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard(
      String title,
      String value) {
    return Card(
      margin:
      const EdgeInsets.only(bottom: 10),

      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}