import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Leaderboard",
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // TOP 3

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,

              children: [

                _topPlayer(
                  "🥈",
                  "Ananya",
                  "1080 XP",
                ),

                _topPlayer(
                  "🥇",
                  "Rahul",
                  "1200 XP",
                ),

                _topPlayer(
                  "🥉",
                  "Kiran",
                  "1020 XP",
                ),
              ],
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView(
                children: const [

                  ListTile(
                    leading: CircleAvatar(
                      child: Text("4"),
                    ),
                    title: Text("Yogi"),
                    trailing: Text("950 XP"),
                  ),

                  ListTile(
                    leading: CircleAvatar(
                      child: Text("5"),
                    ),
                    title: Text("Priya"),
                    trailing: Text("900 XP"),
                  ),

                  ListTile(
                    leading: CircleAvatar(
                      child: Text("6"),
                    ),
                    title: Text("Arjun"),
                    trailing: Text("870 XP"),
                  ),

                  ListTile(
                    leading: CircleAvatar(
                      child: Text("7"),
                    ),
                    title: Text("Sana"),
                    trailing: Text("850 XP"),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius:
                BorderRadius.circular(15),
              ),

              child: const Column(
                children: [

                  Text(
                    "Your Rank",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "#4",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topPlayer(
      String medal,
      String name,
      String xp,
      ) {
    return Column(
      children: [

        Text(
          medal,
          style: const TextStyle(
            fontSize: 40,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(xp),
      ],
    );
  }
}