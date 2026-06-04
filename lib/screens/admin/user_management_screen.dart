import 'package:flutter/material.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("User Management"),
        backgroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Users",
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [

                _userTile(
                  "Yogi",
                  "Student",
                  Icons.school,
                  Colors.blue,
                ),

                _userTile(
                  "Rahul",
                  "Mentor",
                  Icons.groups,
                  Colors.orange,
                ),

                _userTile(
                  "Priya",
                  "Teacher",
                  Icons.badge,
                  Colors.green,
                ),

                _userTile(
                  "Admin User",
                  "Admin",
                  Icons.admin_panel_settings,
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _userTile(
      String name,
      String role,
      IconData icon,
      Color color,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),

          child: Icon(
            icon,
            color: color,
          ),
        ),

        title: Text(name),

        subtitle: Text(role),

        trailing: PopupMenuButton(
          itemBuilder: (context) => [

            const PopupMenuItem(
              value: "view",
              child: Text("View"),
            ),

            const PopupMenuItem(
              value: "edit",
              child: Text("Edit"),
            ),

            const PopupMenuItem(
              value: "delete",
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}