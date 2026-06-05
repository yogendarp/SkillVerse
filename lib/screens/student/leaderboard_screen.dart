import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leaders = [
      {"name": "Rahul", "xp": "1250", "rank": "🥇"},
      {"name": "Yogi", "xp": "1180", "rank": "🥈"},
      {"name": "Sneha", "xp": "1020", "rank": "🥉"},
      {"name": "Kiran", "xp": "950", "rank": "4"},
      {"name": "Ananya", "xp": "900", "rank": "5"},
    ];

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
            child: ListView.builder(
              itemCount: leaders.length,

              itemBuilder: (context, index) {
                final user = leaders[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        user["rank"]!,
                      ),
                    ),

                    title: Text(
                      user["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      "${user["xp"]} XP",
                    ),

                    trailing: index == 1
                        ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "You",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}