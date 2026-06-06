import 'package:flutter/material.dart';

class ShowcaseManagementScreen extends StatelessWidget {
  const ShowcaseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Showcase Management"),
        backgroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Create Showcase feature coming soon"),
            ),
          );
        },

        child: const Icon(Icons.add),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Upcoming Showcases",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _showcaseCard(
              context,
              title: "Robotics Showcase 2026",
              date: "15 August 2026",
              venue: "Innovation Lab",
              participants: "25",
            ),

            _showcaseCard(
              context,
              title: "Chess Championship",
              date: "28 August 2026",
              venue: "Main Auditorium",
              participants: "40",
            ),

            const SizedBox(height: 25),

            const Text(
              "Recent Showcases",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _completedShowcase(
              "Coding Expo",
              "Completed",
            ),

            _completedShowcase(
              "Photography Exhibition",
              "Completed",
            ),
          ],
        ),
      ),
    );
  }

  Widget _showcaseCard(
  BuildContext context, {
    required String title,
    required String date,
    required String venue,
    required String participants,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("📅 Date : $date"),
            Text("📍 Venue : $venue"),
            Text("👥 Participants : $participants"),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Viewing $title"),
                        ),
                      );
                    },
                    child: const Text("View"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Editing $title"),
                        ),
                      );
                    },
                    child: const Text("Edit"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _completedShowcase(
      String title,
      String status,
      ) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.emoji_events,
          color: Colors.orange,
        ),
        title: Text(title),
        subtitle: Text(status),
      ),
    );
  }
}