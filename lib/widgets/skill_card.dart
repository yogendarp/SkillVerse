import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String skillName;
  final String level;
  final int xp;

  const SkillCard({
    super.key,
    required this.skillName,
    required this.level,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Text(
            "Current Skill",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            skillName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Level: $level",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

          Text(
            "XP: $xp",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}