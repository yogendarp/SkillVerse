import 'package:flutter/material.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skill Showcase"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _showcaseCard(
            title: "Chess Tournament Strategy",
            skill: "Chess ♟",
            author: "Yogi",
            likes: "42",
            date: "2 Days Ago",
          ),

          _showcaseCard(
            title: "AI Attendance Tracker",
            skill: "AI & ML 🤖",
            author: "Rahul",
            likes: "67",
            date: "1 Week Ago",
          ),

          _showcaseCard(
            title: "Photography Portfolio",
            skill: "Photography 📸",
            author: "Sneha",
            likes: "38",
            date: "3 Days Ago",
          ),
        ],
      ),
    );
  }

  static Widget _showcaseCard({
    required String title,
    required String skill,
    required String author,
    required String likes,
    required String date,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              height: 180,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(15),
              ),

              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 60,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(skill),

            const SizedBox(height: 10),

            Row(
              children: [

                const Icon(
                  Icons.person,
                  size: 18,
                ),

                const SizedBox(width: 5),

                Text(author),

                const Spacer(),

                Text(date),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),

                const SizedBox(width: 5),

                Text("$likes Likes"),

                const Spacer(),

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility),
                  label: const Text("View"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}