import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingSkillsScreen extends StatelessWidget {
  const PendingSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Pending Skills",
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
              child:
              CircularProgressIndicator(),
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

              final skill =
              skills[index];

              final data =
              skill.data()
              as Map<String, dynamic>;

              return Card(

                margin:
                const EdgeInsets.all(10),

                child: ListTile(

                  title: Text(
                    data["skillName"],
                  ),

                  subtitle: Text(
                    data["level"],
                  ),

                  trailing: Row(
                    mainAxisSize:
                    MainAxisSize.min,

                    children: [

                      IconButton(

                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),

                        onPressed: () async {

                          await FirebaseFirestore
                              .instance
                              .collection("skills")
                              .doc(skill.id)
                              .update({

                            "status":
                            "Approved",

                          });
                        },
                      ),

                      IconButton(

                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),

                        onPressed: () async {

                          await FirebaseFirestore
                              .instance
                              .collection("skills")
                              .doc(skill.id)
                              .update({

                            "status":
                            "Rejected",

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