import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/showcase_service.dart';

class ShowcaseHistoryScreen extends StatelessWidget {
  const ShowcaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Showcase History"),
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: ShowcaseService()
            .getStudentShowcases(userId),

        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("No Data"),
            );
          }

          final showcases = snapshot.data!.docs;

          if (showcases.isEmpty) {
            return const Center(
              child: Text(
                "No showcase evaluations yet",
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(15),

            itemCount: showcases.length,

            itemBuilder: (context, index) {

              final data =
              showcases[index].data()
              as Map<String, dynamic>;

              return Card(
                margin:
                const EdgeInsets.only(bottom: 15),

                child: Padding(
                  padding:
                  const EdgeInsets.all(18),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Week ${data["week"]}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "Skill : ${data["skillName"]}",
                      ),

                      Text(
                        "Score : ${data["score"]}",
                      ),

                      Text(
                        "XP Earned : ${data["xp"]}",
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Teacher Feedback",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        data["feedback"],
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