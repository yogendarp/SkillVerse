import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SkillReviewScreen extends StatelessWidget {
  const SkillReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Skill Reviews",
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance
            .collection("skills")
            .where(
          "status",
          isEqualTo: "Pending",
        )
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final skills =
              snapshot.data!.docs;

          if (skills.isEmpty) {

            return const Center(
              child: Text(
                "No Pending Skills",
              ),
            );
          }

          return ListView.builder(

            itemCount: skills.length,

            itemBuilder: (context, index) {

              final skill = skills[index];

              final data =
              skill.data()
              as Map<String, dynamic>;

              return Card(

                margin: const EdgeInsets.all(10),

                  child: ListTile(
                      leading: const Icon(
                        Icons.workspace_premium,
                      ),

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                      data["studentName"] ?? "Unknown Student",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 4),

                  Text(
                    data["skillName"] ?? "",
                  ),
                  ],

              ),

              subtitle: Text(
              "Level: ${data["level"]}",
              ),

              trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

              IconButton(
              icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              ),
              onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("skills")
                  .doc(skill.id)
                  .update({
              "status": "Approved",
              });
              },
              ),

              IconButton(
              icon: const Icon(
              Icons.cancel,
              color: Colors.red,
              ),
              onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("skills")
                  .doc(skill.id)
                  .update({
              "status": "Rejected",
              });
              },
              ),
              ],

              ),
              ),

              );
            },
          );
        },
      ),
    );
  }
}