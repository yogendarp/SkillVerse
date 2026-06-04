import 'package:flutter/material.dart';

class SkillChangeRequestScreen extends StatefulWidget {
  const SkillChangeRequestScreen({super.key});

  @override
  State<SkillChangeRequestScreen> createState() =>
      _SkillChangeRequestScreenState();
}

class _SkillChangeRequestScreenState
    extends State<SkillChangeRequestScreen> {

  final TextEditingController reasonController =
  TextEditingController();

  String? selectedSkill;

  final List<String> availableSkills = [
    "Coding 💻",
    "Robotics 🤖",
    "Football ⚽",
    "Cricket 🏏",
    "Public Speaking 🎤",
    "Photography 📷",
    "Artificial Intelligence 🧠",
    "Entrepreneurship 🚀",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Skill Change Request",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Current Skill Card

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "Current Skill",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Chess ♟",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Time in Skill: 5 Months",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Requested Skill",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedSkill,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
              ),

              items: availableSkills.map((skill) {
                return DropdownMenuItem(
                  value: skill,
                  child: Text(skill),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedSkill = value;
                });
              },
            ),

            const SizedBox(height: 25),

            const Text(
              "Reason",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: reasonController,
              maxLines: 5,

              decoration: InputDecoration(
                hintText:
                "Explain why you want to change your skill...",
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius:
                BorderRadius.circular(15),
              ),

              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "Skill Change Policy",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "• Minimum duration in a skill community is 4 months.\n"
                        "• Teacher review is mandatory.\n"
                        "• Performance and attendance will be evaluated.\n"
                        "• Approval is not guaranteed.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {

                  if (selectedSkill == null) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please select a skill",
                        ),
                      ),
                    );

                    return;
                  }

                  if (reasonController.text
                      .trim()
                      .isEmpty) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please enter a reason",
                        ),
                      ),
                    );

                    return;
                  }

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Request submitted successfully",
                      ),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                ),

                child: const Text(
                  "Submit Request",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}