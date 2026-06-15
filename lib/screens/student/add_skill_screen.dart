import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/skill_service.dart';

class AddSkillScreen extends StatefulWidget {
  const AddSkillScreen({super.key});

  @override
  State<AddSkillScreen> createState() =>
      _AddSkillScreenState();
}

class _AddSkillScreenState
    extends State<AddSkillScreen> {

  final skillController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  String selectedLevel = "Beginner";

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Skill"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: skillController,
              decoration: const InputDecoration(
                labelText: "Skill Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedLevel,

              decoration: const InputDecoration(
                labelText: "Level",
                border: OutlineInputBorder(),
              ),

              items: const [

                DropdownMenuItem(
                  value: "Beginner",
                  child: Text("Beginner"),
                ),

                DropdownMenuItem(
                  value: "Intermediate",
                  child: Text("Intermediate"),
                ),

                DropdownMenuItem(
                  value: "Advanced",
                  child: Text("Advanced"),
                ),
              ],

              onChanged: (value) {

                setState(() {
                  selectedLevel = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: () async {

                  if(skillController.text.trim().isEmpty){
                    return;
                  }

                  setState(() {
                    loading = true;
                  });

                  await SkillService().addSkill(

                    userId:
                    FirebaseAuth.instance
                        .currentUser!.uid,

                    skillName:
                    skillController.text.trim(),

                    description:
                    descriptionController.text.trim(),

                    level: selectedLevel,
                  );

                  setState(() {
                    loading = false;
                  });

                  if(context.mounted){

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Skill Added Successfully",
                        ),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },

                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Add Skill"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}