import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/spotlight_service.dart';

class SpotlightScreen extends StatelessWidget {
  const SpotlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌟 Spotlight"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: SpotlightService().getSpotlight(),

        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final showcases = snapshot.data!.docs;

          if (showcases.isEmpty) {
            return const Center(
              child: Text(
                "No Spotlight entries yet",
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [

              // Spotlight Banner

              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),

                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Column(
                  children: [

                    Icon(
                      Icons.auto_awesome,
                      color: Colors.deepPurple,
                      size: 45,
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Spotlight",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Celebrating outstanding weekly performances.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              ...showcases.asMap().entries.map((entry) {

                final index = entry.key;
                final data =
                entry.value.data() as Map<String, dynamic>;

                final score = data["score"] ?? 0;

                Color borderColor = Colors.grey;

                if (score >= 95) {
                  borderColor = Colors.amber;
                } else if (score >= 90) {
                  borderColor = Colors.blueGrey;
                } else if (score >= 80) {
                  borderColor = Colors.brown;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 18),
                  elevation: 4,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: borderColor,
                      width: 2,
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(18),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        if (index == 0)

                          Container(
                            margin: const EdgeInsets.only(bottom: 15),

                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              borderRadius: BorderRadius.circular(25),
                            ),

                            child: const Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [

                                Icon(
                                  Icons.workspace_premium,
                                  color: Colors.orange,
                                ),

                                SizedBox(width: 8),

                                Text(
                                  "Featured Performer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        Text(
                          data["studentName"],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [

                            const Icon(Icons.school,size:20),

                            const SizedBox(width:8),

                            Expanded(
                              child: Text(
                                data["skillName"],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height:10),

                        Row(
                          children: [

                            const Icon(Icons.star,color:Colors.orange,size:20),

                            const SizedBox(width:8),

                            Text(
                              "Score : ${data["score"]}/100",
                            ),
                          ],
                        ),

                        const SizedBox(height:10),

                        Row(
                          children: [

                            const Icon(Icons.bolt,
                                color: Colors.green,
                                size:20),

                            const SizedBox(width:8),

                            Text(
                              "XP Earned : +${data["xp"]}",
                            ),
                          ],
                        ),

                        const SizedBox(height:10),

                        Row(
                          children: [

                            const Icon(Icons.calendar_today,size:18),

                            const SizedBox(width:8),

                            Text(
                              "Week ${data["week"]}",
                            ),
                          ],
                        ),

                        const SizedBox(height:20),

                        const Text(
                          "Teacher Feedback",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height:10),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),

                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius:
                            BorderRadius.circular(15),
                          ),

                          child: Text(
                            data["feedback"],
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              }).toList(),
            ],
          );
        },
      ),
    );
  }
}