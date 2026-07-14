import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),

        actions: [

          StreamBuilder<QuerySnapshot>(

            stream: NotificationService().getNotifications(
              FirebaseAuth.instance.currentUser!.uid,
            ),

            builder: (context, snapshot) {

              if (!snapshot.hasData ||
                  snapshot.data!.docs.isEmpty) {

                return const SizedBox();
              }

              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                tooltip: "Clear All",
                onPressed: () async {

                  final confirm =
                  await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text(
                        "Clear all notifications?",
                      ),
                      content: const Text(
                        "All notifications will be removed. New notifications will continue to appear automatically.",
                      ),
                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Cancel"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("Clear"),
                        ),
                      ],
                    ),
                  );

                  if (confirm != true) return;

                  final docs = await FirebaseFirestore.instance
                      .collection("notifications")
                      .where(
                    "userId",
                    isEqualTo:
                    FirebaseAuth.instance.currentUser!.uid,
                  )
                      .get();

                  for (final doc in docs.docs) {
                    await doc.reference.delete();
                  }

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "All notifications cleared",
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: NotificationService()
            .getNotifications(
          FirebaseAuth
              .instance
              .currentUser!
              .uid,
        ),

        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final notifications =
              snapshot.data!.docs;

          if (notifications.isEmpty) {
            return const Center(

              child: Column(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.notifications_off,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "You're all caught up!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "New notifications will appear here.",
                  ),

                ],
              ),
            );
          }

          return ListView.builder(

            itemCount:
            notifications.length,

            itemBuilder: (context, index) {

              final data =
              notifications[index]
                  .data()
              as Map<String, dynamic>;

              Timestamp? timestamp = data["createdAt"];

              String time = "";

              if (timestamp != null) {

                time = timeago.format(
                  timestamp.toDate(),
                );

              }

              IconData icon = Icons.notifications;
              Color color = Colors.blue;

              String title =
                  data["title"] ?? "";

              if (title.contains("Approved")) {

                icon = Icons.check_circle;
                color = Colors.green;

              }
              else if (title.contains("Rejected")) {

                icon = Icons.cancel;
                color = Colors.red;

              }
              else if (title.contains("Achievement")) {

                icon = Icons.emoji_events;
                color = Colors.orange;

              }
              else if (title.contains("Attendance")) {

                icon = Icons.calendar_month;
                color = Colors.indigo;

              }
              else if (title.contains("Showcase")) {

                icon = Icons.star;
                color = Colors.purple;

              }

              return Dismissible(

                key: Key(notifications[index].id),

                direction: DismissDirection.endToStart,

                background: Container(

                  alignment: Alignment.centerRight,

                  padding: const EdgeInsets.only(right: 25),

                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                onDismissed: (_) async {

                  await notifications[index]
                      .reference
                      .delete();

                  ScaffoldMessenger.of(context).showSnackBar(

                    SnackBar(

                      content: const Text(
                        "Notification deleted",
                      ),

                      action: SnackBarAction(

                        label: "UNDO",

                        onPressed: () {

                          FirebaseFirestore.instance
                              .collection("notifications")
                              .doc(notifications[index].id)
                              .set(data);

                        },
                      ),
                    ),
                  );
                },

                child: NotificationTile(

                  icon: icon,

                  color: color,

                  title: title,

                  subtitle: data["message"] ?? "",

                  time: time,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}