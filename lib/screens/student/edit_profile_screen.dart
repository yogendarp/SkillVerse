import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/database_service.dart';
import '../../services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final nameController = TextEditingController();

  final institutionController =
  TextEditingController();

  String educationLevel = "College";

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {

    String uid =
        FirebaseAuth.instance.currentUser!.uid;

    var userData =
    await UserService().getUserData(uid);

    if(userData != null){

      nameController.text =
          userData["name"] ?? "";

      institutionController.text =
          userData["institution"] ?? "";

      educationLevel =
          userData["educationLevel"] ??
              "College";

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: institutionController,
              decoration: const InputDecoration(
                labelText: "Institution",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: educationLevel,

              decoration: const InputDecoration(
                labelText: "Education Level",
                border: OutlineInputBorder(),
              ),

              items: const [

                DropdownMenuItem(
                  value: "School",
                  child: Text("School"),
                ),

                DropdownMenuItem(
                  value: "College",
                  child: Text("College"),
                ),

                DropdownMenuItem(
                  value: "University",
                  child: Text("University"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  educationLevel = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                  String uid =
                      FirebaseAuth.instance.currentUser!.uid;

                  await DatabaseService().updateUser(
                    uid: uid,
                    name: nameController.text.trim(),
                    institution:
                    institutionController.text.trim(),
                    educationLevel: educationLevel,
                  );

                  if(context.mounted){

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Profile Updated Successfully",
                        ),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}