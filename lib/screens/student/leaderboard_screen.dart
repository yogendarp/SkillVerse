import 'package:flutter/material.dart';
import '../../services/leaderboard_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
      ),

      body: Column(
        children: [

          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Column(
              children: [

                Icon(
                  Icons.emoji_events,
                  size: 50,
                  color: Colors.orange,
                ),

                SizedBox(height: 10),

                Text(
                  "Top Skill Performers",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "Compete and climb the ranks!",
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: LeaderboardService().getLeaderboard(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final leaders = snapshot.data!;

                return ListView.builder(
                  itemCount: leaders.length,

                  itemBuilder: (context, index) {

                    final user = leaders[index];

                    String rank = "";

                    if (index == 0) {
                      rank = "🥇";
                    } else if (index == 1) {
                      rank = "🥈";
                    } else if (index == 2) {
                      rank = "🥉";
                    } else {
                      rank = "${index + 1}";
                    }
                    String currentUserName = "";

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),

                      child: ListTile(

                        leading: CircleAvatar(
                          backgroundColor:
                          index == 0
                              ? Colors.amber
                              : index == 1
                              ? Colors.grey
                              : index == 2
                              ? Colors.brown
                              : null,

                          child: Text(rank),
                        ),

                        title: Text(
                          user["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          "Attendance: ${user["attendance"].toStringAsFixed(1)}%",
                        ),

                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              "${user["score"].toStringAsFixed(1)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const Text("Score"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}