import 'package:flutter/material.dart';

class AllSkillsScreen extends StatelessWidget {
  const AllSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Explore Skills",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          buildCategory(
            "Sports",
            [
              "Chess ♟",
              "Cricket 🏏",
              "Football ⚽",
              "Basketball 🏀",
              "Athletics 🏃",
            ],
          ),

          buildCategory(
            "Technology",
            [
              "Coding 💻",
              "Robotics 🤖",
              "Artificial Intelligence 🧠",
              "Cyber Security 🔐",
              "App Development 📱",
            ],
          ),

          buildCategory(
            "Arts",
            [
              "Drawing 🎨",
              "Painting 🖌",
              "Photography 📷",
              "Music 🎵",
              "Dance 💃",
            ],
          ),

          buildCategory(
            "Communication",
            [
              "Public Speaking 🎤",
              "Debate 🗣",
              "Storytelling 📖",
              "Content Creation 🎬",
            ],
          ),

          buildCategory(
            "Leadership",
            [
              "Entrepreneurship 🚀",
              "Event Management 🎪",
              "Team Leadership 👥",
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategory(
      String title,
      List<String> skills,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,

              children: skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor:
                  const Color(0xFF2563EB).withOpacity(0.1),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}